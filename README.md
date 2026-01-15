# AWS Snowflake dbt Project

A data transformation pipeline for Airbnb analytics using dbt and Snowflake, implementing a medallion architecture (Bronze → Silver → Gold).

## 📊 Project Overview

This project transforms raw Airbnb data through three layers:
- **Bronze**: Raw data ingestion from staging
- **Silver**: Cleaned and enriched data
- **Gold**: Analytics-ready fact tables and dimensions

## 🏗️ Architecture

```
staging (Snowflake)
    ↓
Bronze Layer (Raw)
    ├── bronze_bookings
    ├── bronze_hosts
    └── bronze_listings
    ↓
Silver Layer (Cleaned)
    ├── silver_bookings (with calculated total_price)
    ├── silver_hosts (with response_rate_quality)
    └── silver_listings (with price tags)
    ↓
Gold Layer (Analytics)
    ├── obt (One Big Table)
    ├── fact (Fact table)
    ├── dim_bookings (SCD Type 2)
    ├── dim_hosts (SCD Type 2)
    └── dim_listings (SCD Type 2)
```

## 🚀 Quick Start

### Prerequisites
- Python 3.12+
- Snowflake account
- dbt-core and dbt-snowflake installed

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo>
   cd aws_snowflake_dbt
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```
   Or with uv:
   ```bash
   uv sync
   ```

3. **Configure credentials**
   - Credentials are in `DE_aws_dbt_snowflake_project/profiles.yml`
   - Update with your Snowflake credentials
   - File is gitignored for security

4. **Navigate to dbt project**
   ```bash
   cd DE_aws_dbt_snowflake_project
   ```

### Running the Project

```bash
# Run all models
dbt run

# Run specific layer
dbt run --select bronze
dbt run --select silver
dbt run --select gold

# Run tests
dbt test

# Generate and view documentation
dbt docs generate
dbt docs serve
```

## 📁 Project Structure

```
DE_aws_dbt_snowflake_project/
├── models/
│   ├── bronze/          # Raw data models
│   ├── silver/          # Cleaned data models
│   ├── gold/            # Analytics models
│   │   └── ephemeral/   # Intermediate models
│   └── sources/         # Source definitions
├── tests/               # Custom data quality tests
├── macros/              # Reusable SQL functions
├── snapshots/           # SCD Type 2 snapshots
├── analyses/            # Ad-hoc analyses
└── seeds/               # Static data files
```

## 🔍 Data Models

### Bronze Layer
- **Materialization**: Incremental tables
- **Purpose**: Raw data from staging with minimal transformation
- **Refresh**: Incremental based on `created_at`

### Silver Layer
- **Materialization**: Incremental tables with unique keys
- **Purpose**: Cleaned, validated, and enriched data
- **Features**:
  - Calculated fields (total_price, response_rate_quality)
  - Data quality validations
  - Foreign key relationships

### Gold Layer
- **Materialization**: Tables
- **Purpose**: Analytics-ready datasets
- **Models**:
  - `obt`: Denormalized one big table for reporting
  - `fact`: Fact table for dimensional modeling
  - `dim_*`: Slowly changing dimensions (Type 2)

## ✅ Data Quality

90+ tests implemented:
- **Uniqueness**: Primary key constraints
- **Not Null**: Critical field validation
- **Referential Integrity**: Foreign key relationships
- **Accepted Values**: Status and category validation
- **Freshness**: Source data monitoring (12hr warn, 24hr error)
- **Custom Tests**: Business logic validation

Run tests:
```bash
dbt test
```

## 🔧 Key Features

### Incremental Models
All bronze and silver models use incremental loading for efficiency:
```sql
{% if is_incremental() %}
  where created_at > (select max(created_at) from {{ this }})
{% endif %}
```

### Custom Macros
- `multiply()`: Precision multiplication
- `tag()`: Price categorization
- `trimming()`: String cleaning
- `generate_schema_name()`: Dynamic schema naming

### Snapshots
SCD Type 2 implementation for tracking historical changes:
- `dim_bookings`
- `dim_hosts`
- `dim_listings`

## 📈 Performance Optimization

- Incremental models reduce processing time
- Unique keys prevent duplicates
- Ephemeral models for intermediate transformations
- Optimized for Snowflake warehouse

## 🔒 Security

- Credentials stored in `profiles.yml` (gitignored)
- No hardcoded passwords in code
- Environment variable support available
- See `SECURITY.md` for details

## 📚 Documentation

Generate interactive documentation:
```bash
dbt docs generate
dbt docs serve
```

Access at: http://localhost:8080

## 🧪 Testing Strategy

```bash
# Test everything
dbt test

# Test specific model
dbt test --select silver_bookings

# Test sources only
dbt test --select source:*
```

## 🔄 Development Workflow

1. Make changes to models
2. Run affected models: `dbt run --select model_name+`
3. Test changes: `dbt test --select model_name+`
4. Generate docs: `dbt docs generate`
5. Commit changes

## 📊 Monitoring

- Source freshness: `dbt source freshness`
- Test results in `target/run_results.json`
- Logs in `logs/dbt.log`

## 🤝 Contributing

1. Create feature branch
2. Make changes
3. Run tests
4. Submit pull request

## 📝 License

[Your License]

## 👥 Authors

[Your Name]

## 🆘 Support

For issues or questions, contact [your-email]
