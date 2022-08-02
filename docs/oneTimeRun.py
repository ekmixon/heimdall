import csv
import os
from datetime import date


today = date.today()
currentPath = os.getcwd()
hostNames = []
ipAddresses = []
username = input("What is the username for this machine(s)?")
password = input("What is the password for this service account?")
scanType = input("How would you like to run this scan, via host name or via ip address?")
nameOfFile = input("What is the name of your csv file where your hostname and IP addresses are stored?")

with open(nameOfFile) as csvDataFile:
    csvReader = csv.reader(csvDataFile)
    for row in csvReader:
        hostNames.append(row[0])
        ipAddresses.append(row[1])

if scanType in ["host name", "hostname", "Host name", "Hostname"]:
    for hostName in hostNames:    
        inspecScan = f"sudo inspec exec inspec-profile-disa_stig-el7/ --attrs=inspec-profile-disa_stig-el7/attributes.yml -t ssh://{username}@{hostName} --sudo --sudo-password={password} --password={password} --reporter cli json:{currentPath}{hostName}-{str(today)}.json"

        os.system(inspecScan)
elif scanType in [
    "ip address",
    "ipaddress",
    "Ip Address",
    "IP Address",
    "IP address",
]:
    for ipAddress in ipAddresses:
        inspecScan = f"sudo inspec exec inspec-profile-disa_stig-el7/ --attrs=inspec-profile-disa_stig-el7/attributes.yml -t ssh://{username}@{ipAddress} --sudo --sudo-password={password} --password={password} --reporter cli json:{currentPath}{ipAddress}-{str(today)}.json"

        os.system(inspecScan)
else:
    scanType = input("How would you like to run this scan, via host name or via ip address?")