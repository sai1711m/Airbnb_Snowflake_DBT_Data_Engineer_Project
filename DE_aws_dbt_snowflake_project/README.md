# AWS Snowflake dbt Project

Data transformation pipeline for Airbnb analytics using dbt and Snowflake.

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Navigate to dbt project
cd DE_aws_dbt_snowflake_project

# Run models
dbt run

# Run tests
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

## Project Structure

- **Bronze Layer**: Raw data ingestion (incremental)
- **Silver Layer**: Cleaned and validated data
- **Gold Layer**: Analytics-ready fact tables and dimensions

## Documentation

See main [README.md](../README.md) for full documentation.

## Data Quality

90+ tests covering:
- Primary key uniqueness
- Not null constraints
- Referential integrity
- Business logic validation
- Source freshness monitoring

## Resources

- [dbt Documentation](https://docs.getdbt.com)
- [dbt Discourse](https://discourse.getdbt.com)
- [dbt Slack Community](https://community.getdbt.com)
