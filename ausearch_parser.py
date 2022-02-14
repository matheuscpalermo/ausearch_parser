import json
import config


def appendAttributes(attributeList):
    attributesDict = {}
    for attribute in attributeList:
            if '=' not in attribute or 'cmd' in attribute or 'proctitle' in attribute:
                break
            else:
                attributeKey = attribute.split('=')[0]
                attributeValue = attribute.split('=')[1]
                attributesDict[attributeKey] = attributeValue
    
    return attributesDict


def rawLogToJson(rawLog):

    logDict = {}
    rawLogLines = rawLog.split('\n')
    logDict['timestamp'] = rawLogLines[0].split('msg=audit(')[1].split('.')[0]
    logDict['id'] = rawLogLines[0].split(':')[3].split(')')[0]
    logDict['type'] = rawLogLines[-1].split('=')[1].split(' ')[0]
    
    for line in rawLogLines:
        line = line.strip('\' ')
        if 'type=PATH' in line or 'type=CWD' in line or 'type=EXECVE' in line :
            continue
        elif 'proctitle' in line:
            logDict['cmd']=line.split('proctitle=')[1].strip()
            continue
        elif 'cmd' in line:
            logDict['cmd']=line.split('cmd=')[1].split(' terminal')[0]
        
        attributeList = line.split(' : ')[1].split(' ')
        logDict.update(appendAttributes(attributeList))
    
    logJson = json.dumps(logDict)
    return logJson


def main():
    # Reads the log file
    with open(config.LOGS_PATH) as f:
        fullText = f.read()

    # Divide the text into a list of logs
    logList=fullText.split("\n----\n")

    logList[0] = logList[0].strip('-\n')

    parsedLogList = []

    # Adds each log in JSON format to a new list
    for rawLog in logList:
        parsedLog = rawLogToJson(rawLog)
        parsedLogList.append(parsedLog)

    # Prints the results
    print(parsedLogList)


if __name__ == "__main__":
    main()