import re

def handler(event, context):

    request = event['Records'][0]['cf']['request']
    location = None

    if re.search('^/extensions/?$', request['uri']):
        location = 'https://www.imsglobal.org/sites/default/files/Badges/OBv2p0Final/extensions/index.html'
    elif request['uri'].startswith('/history'):
        location = 'https://www.imsglobal.org/sites/default/files/Badges/OBv2p0Final/index.html#History'
    elif request['uri'].startswith('/baking'):
        location = 'https://www.imsglobal.org/sites/default/files/Badges/OBv2p0Final/baking/index.html'

    if not location:
        return request

    response = {
        'status': '302',
        'statusDescription': 'Found',
        'headers': {
            'location': [{
                'key': 'Location',
                'value': location
            }]
        }
    }

    return response
