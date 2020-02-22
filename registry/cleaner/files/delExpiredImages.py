#!/usr/bin/env python
# -*- coding:utf-8 -*-
import requests
import json
import datetime
import os
import time
from requests.auth import HTTPBasicAuth
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class RegistryManager():
    def __init__(self, host, username, password):
        self.headers = {}
        self.headers["Accept"] = 'application/vnd.docker.distribution.manifest.v2+json'
        self.host = host
        self.username = username
        self.password = password
        self.sender = requests.Session()


    def get_image(self, name):
        url = self.host + '/v2/' + str(name) + '/tags/list'
        req = requests.Request('GET', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        if resp.status_code < 400:
            return resp.content
        return False

    def get_digest(self, name, tag):
        url = self.host + '/v2/' + str(name) + '/manifests/' + str(tag)
        req = requests.Request('GET', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        if resp.status_code < 400:
            return resp.headers["Docker-Content-Digest"]
        return False

    def del_digest(self,name, digest):
        url = self.host + '/v2/' + str(name) + '/manifests/' + str(digest)
        req = requests.Request('DELETE', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        if resp.status_code < 400:
            return True
        return False


def tag_to_time(tag):
    """
    :param tag: 传入image的标签
    :return: 将标签转换成datetime时间格式返回
    """
    spliter = tag.split('.')
    # 必须符合时间tag格式才行
    if len(spliter) >= 3:
        if spliter[-1].isdigit() and spliter[-2].isdigit():
            return datetime.datetime.strptime(str(spliter[-2]) + str(spliter[-1]), '%y%m%d')
    return False



if __name__ == '__main__':

    name = os.getenv('IMAGE_NAME')
    period_of_validity = int(os.getenv('IMAGE_KEEP_INTERVAL'))
    registry_url = os.getenv('REGISTRY_URL')
    registry_username = os.getenv('REGISTRY_USERNAME')
    registry_password = os.getenv('REGISTRY_PASSWORD')

    if not all([name, period_of_validity, registry_url, registry_username, registry_password]):
        raise ValueError('ERROR! env IMAGE_NAME,IMAGE_KEEP_INTERVAL,REGISTRY_URL,REGISTRY_USERNAME,REGISTRY_PASSWORD must be set')

    manager = RegistryManager(registry_url, registry_username, registry_password)
    now = datetime.datetime.now()
    image_info = manager.get_image(name)

    if not image_info:
        raise ValueError('Get image of ' + name + ' with ERROR!, Maybe username or password is incorrect')
    tags = json.loads(image_info).get('tags')

    for tag in tags:
        tag_time = tag_to_time(tag)
        # 确保能够解析成时间标签，否则时间加减会错误
        if tag_time:
            if (now - tag_time).days > period_of_validity:
                digest = manager.get_digest(name, tag)
                print('Prepare to delete tag: ' + str(tag) + ' of ' + str(name) + ' Which digest is: ' + str(digest))
                if manager.del_digest(name, digest):
                    print(str(digest) + ' has been deleted')
                else:
                    print(str(digest) + ' deleted with ERROR!')
            else:
                print(tag + ' is in valid time, Skipped!')

    print('Prune image has been completed, Starting to sleep 15s for log havester')
    time.sleep(15)
