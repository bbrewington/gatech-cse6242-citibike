import json
import os
import re

def generate_static_dbt_docs(input_html='index.html', output_dir='docs', output_html='dbt_docs.html', \
    dbt_project_path='citibike_dbt', projects_to_ignore=['dbt', 'dbt_bigquery']):
    """After running `dbt docs generate`, Export documentation as a static html page
    Taken from Data banana article: https://data-banana.github.io/dbt-generate-doc-in-one-static-html-file.html
    """
    search_str = 'o=[i("manifest","manifest.json"+t),i("catalog","catalog.json"+t)]'

    with open(os.path.join(dbt_project_path, 'target', input_html), 'r') as f:
        content_index = f.read()

    with open(os.path.join(dbt_project_path, 'target', 'manifest.json'), 'r') as f:
        json_manifest = json.loads(f.read())

    # In the static website there are 2 more projects inside the documentation: dbt and dbt_bigquery
    # This is technical information that we don't want to provide to our final users, so we drop it
    # Note: depends of the connector, here we use BigQuery
    for element_type in ['nodes', 'sources', 'macros', 'parent_map', 'child_map']:  # navigate into manifest
        # We transform to list to not change dict size during iteration, we use default value {} to handle KeyError
        for key in list(json_manifest.get(element_type, {}).keys()):
            for ignore_project in projects_to_ignore:
                if re.match(fr'^.*\.{ignore_project}\.', key):  # match with string that start with '*.<ignore_project>.'
                    del json_manifest[element_type][key]  # delete element

    with open(os.path.join(dbt_project_path, 'target', 'catalog.json'), 'r') as f:
        json_catalog = json.loads(f.read())

    output_filepath = os.path.join(dbt_project_path, output_dir, output_html)
    with open(output_filepath, 'w') as f:
        new_str = "o=[{label: 'manifest', data: " + json.dumps(json_manifest)
        new_str += "},{label: 'catalog', data: " + json.dumps(json_catalog) + "}]"
        new_content = content_index.replace(search_str, new_str)
        print('dbt_utility.generate_static_dbt_docs: writing to ' + output_filepath)
        f.write(new_content)
    
    return output_filepath

if __name__ == '__main__':
    generate_static_dbt_docs()
