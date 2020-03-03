# L2TP

* COPY from fcojean/l2tp-ipsec-vpn-server

* windows10 connnecting without response, run command `REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f`