def handler(event, context):
    response = event['Records'][0]['cf']['response']

    if int(response['status']) >= 400:
        response['status'] = '302'
        response['statusDescription'] = 'Found'
        response['headers']['location'] = [{
            'key': 'Location',
            'value': 'https://www.imsglobal.org/sites/default/files/Badges/OBv2p0Final/index.html'
        }]

    return response
