#/usr/bin/python3

from jinja2 import Template
import json
import os
import logging

logging.basicConfig(format='[%(levelname)s]\t%(message)s',level=logging.INFO)
languages = ['en','ru']
logging.info('Localizations to make: {}'.format(languages))
templates = ['index.html','experience.html','techstack.html']
logging.info('Templates to fill: {}'.format(templates))

def generateLocalizedPage(templateName, language):
  with open(templateName) as t:
    template = Template(t.read())
  with open(language, 'r') as langfile:
    filling = json.load(langfile)
  os.makedirs('results/{}'.format(language), exist_ok = True)
  with open('results/{}/{}'.format(language, templateName), 'w') as output:
    output.write(template.render(filling))
  logging.info('Generated {} version for {}'.format(language, templateName))

os.makedirs('results')
for template in templates:
  for language in languages:
    generateLocalizedPage(template, language)
