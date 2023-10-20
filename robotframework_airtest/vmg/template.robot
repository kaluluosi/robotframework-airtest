*** Settings ***
Documentation    {{ui.name}} 界面模型文件    注意：这个文件是导出生成的不要修改。

{%  for library in ui.libraries  %}
Library    {{library}}
{% endfor %}

{%  for resource in ui.resources  %}
Resource    {{resource}}
{% endfor %}


*** Variables ***
${{ '{' }}{{ ui.name }}{{ '}'}}    {{ ui.path }}

{% for var in ui.variables %}
${{ '{' }}{{ui.name}}.{{ var.name }}{{ '}'}}    {{ var.path }}
{% endfor %}

*** Keywords ***
{% for var in ui.variables %}
    {% for action in var.actions %}
{{action|safe}}
    {% endfor %}
{% endfor %}
