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


class RegistryManager:
    def __init__(self, host, username, password):
        self.headers = dict()
        self.headers["Accept"] = 'application/vnd.docker.distribution.manifest.v2+json'
        self.host = host
        self.username = username
        self.password = password
        self.sender = requests.Session()

    def get_image_list(self):
        url = self.host + '/v2/_catalog'
        req = requests.Request('GET', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        return resp.status_code, resp.json()

    def get_tags(self, name):
        url = self.host + '/v2/' + str(name) + '/tags/list'
        req = requests.Request('GET', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        return resp.status_code, resp.json()

    def get_tag_digest(self, name, tag):
        url = self.host + '/v2/' + str(name) + '/manifests/' + str(tag)
        req = requests.Request('GET', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        return resp.status_code, resp.headers

    def del_digest(self, name, digest):
        url = self.host + '/v2/' + str(name) + '/manifests/' + str(digest)
        req = requests.Request('DELETE', url=url, auth=HTTPBasicAuth(self.username, self.password), headers=self.headers)
        resp = self.sender.send(req.prepare(), verify=False)
        return resp.status_code


def tag_to_time(tag):
    """
    :param tag: 传入image的标签
    :return: 将标签转换成datetime时间格式返回
    """
    spliter = tag.split('.')
    # 必须符合时间tag格式才行
    if len(spliter) >= 3 and spliter[-1].isdigit() and spliter[-2].isdigit():
        try:
            time_tag = datetime.datetime.strptime(str(spliter[-2]) + str(spliter[-1]), '%y%m%d')
            return time_tag
        except Exception as e:
            print('Error！tag transfer with exception: ' + str(e))
    return False


if __name__ == '__main__':
    names = os.getenv('IMAGE_NAMES')
    period_of_validity = int(os.getenv('IMAGE_KEEP_INTERVAL'))
    registry_url = os.getenv('REGISTRY_URL')
    registry_username = os.getenv('REGISTRY_USERNAME')
    registry_password = os.getenv('REGISTRY_PASSWORD')

    if not all([names, period_of_validity, registry_url, registry_username, registry_password]):
        raise ValueError('ERROR! env IMAGE_NAMES,IMAGE_KEEP_INTERVAL,REGISTRY_URL,REGISTRY_USERNAME,REGISTRY_PASSWORD must be set')

    manager = RegistryManager(registry_url, registry_username, registry_password)
    now = datetime.datetime.now()

    # 使用逗号隔开则循环清理
    for name in names.split(','):
        name = name.strip()
        if not name:
            continue
        try:
            _code, image_info = manager.get_tags(name)
        except Exception as e:
            raise ConnectionError('Error! Connecting to ' + manager.host + ' with Exception')

        if _code == 404:
            print('Warning! image of ' + str(name) + ' not found!')
            continue
        elif _code == 401:
            print('Error! Authentication Failed')
            break
        elif _code > 400:
            print('Error! Failed to get image of ' + name)
            continue
        tags = image_info.get('tags')

        for tag in tags:
            time_tag = tag_to_time(tag)
            # 确保能够解析成时间标签，否则时间加减会错误
            if not time_tag:
                continue
            if (now - time_tag).days >= period_of_validity:
                _code, digest_header = manager.get_tag_digest(name, tag)
                if _code == 404:
                    print('Error! tag of ' + str(name) + ':' + str(tag) + ' not found!')
                    continue
                elif _code > 400:
                    print('Error! Get digest of ' + str(name) + ':' + str(tag) + ' failed')
                    continue
                digest = digest_header['Docker-Content-Digest']
                print('OK! digest of ' + str(name) + ':' + str(tag) + ' is: ' + str(digest))
                _code = manager.del_digest(name, digest)
                if _code > 400:
                    print('Error! ' + str(name) + ':' + str(tag) + ' deleted with Exception!')
                else:
                    print('Deleted! ' + str(name) + ':' + str(tag) + ' has been deleted')
            else:
                print('Skipped! ' + str(name) + ':' + str(tag) + ' is Skipped!')

    print('\n\nPrune image has been completed, Starting to sleep 15s for log havester')
    print('Please run command "registry garbage-collect  /etc/docker/registry/config.yml --delete-untagged=true" to remove blob data')
    time.sleep(15)
