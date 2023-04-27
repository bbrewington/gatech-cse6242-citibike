# dbt project: citibike_dbt

## Environment Setup

Ok to run from top level of repo (there's a cd command in the .sh file)

This will activate a virtualenv & install dbt-bigquery (pinned to a version) into it, and run `dbt debug` as a connection test

```bash
source citibike_dbt/setup.sh
```

## Folders

* **/analyses**: analytical sql files that are versioned inside dbt project.  Any query in this directory will be compiled, but not executed (via `dbt compile`), which outputs to `target/compiled/{project name}/analyses/query_file_name.sql` ([link to dbt analyses docs](https://docs.getdbt.com/docs/building-a-dbt-project/analyses))
* **/macros**: Jinja macro files, analogous to "functions" in Python.  Defined as .sql files ([link to dbt macros docs](https://docs.getdbt.com/docs/building-a-dbt-project/jinja-macros))
* **/models**: a select statement defined in .sql files in this directory ([link to dbt models docs](https://docs.getdbt.com/docs/building-a-dbt-project/building-models))
  - Each .sql file contains one model / select statement
  - Name of the file is used as the model name
  - Models can be nested in subdirectories within the models directory
  - When you execute the dbt run command, dbt will build this model in the data warehouse by wrapping it in a `create view` or as a `create table` statement
* **/seeds**: CSV files in the dbt project (typically the seeds directory), that dbt can load into the data warehouse using the `dbt seed` command ([link to dbt seeds docs](https://docs.getdbt.com/docs/building-a-dbt-project/seeds))
* **/snapshots**: records changes to a mutable table over time, as type-2 slowly changing dimensions ([link to dbt snapshots docs](https://docs.getdbt.com/docs/building-a-dbt-project/snapshots))
* **/target**: not shown in github...gets created on command `dbt run`
* **/tests**: assertions you make about your models and other resources in your dbt project (e.g. sources, seeds and snapshots). When you run dbt test, dbt will tell you if each test in your project passes or fails. dbt ships with these out of the box: `unique`, `not_null`, `accepted_values` and `relationships` ([link to dbt tests docs](https://docs.getdbt.com/docs/building-a-dbt-project/tests))
