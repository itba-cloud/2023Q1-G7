import boto3, json


def main(event, context):
    # client = boto3.client('dynamodb')  # this will create dynamodb resource object and
    #
    # # Esta data está mockeada
    #
    # client.put_item(Item={
    #     "appointment-id": {
    #         "S": "1"
    #     },
    #     "date": {
    #         "S": "10/02/22"
    #     },
    #     "assigned_to": {
    #         "S": "pepe"
    #     },
    #     "client": {
    #         "S": "juancito"
    #     }
    # },
    #     TableName='appointments-table')

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*',
        },
        "body": "hola mundo"
    }
