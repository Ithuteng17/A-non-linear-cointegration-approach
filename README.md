# Non-Linear Cointegration Approach: MS-VECM for Exchange Rate Analysis

A comprehensive research project implementing a non-linear cointegration approach using Markov-Switching Vector Error Correction Model (MS-VECM) with two regimes for analyzing exchange rate relationships.

## 📋 Overview

Traditional Granger cointegration approaches assume linear relationships between variables. However, financial time series—particularly exchange rates—often exhibit non-linear behavior. This project introduces a hybrid MS-VECM framework that accounts for regime-switching dynamics and non-linear cointegration patterns in foreign exchange markets.

### Key Innovation
The research combines:
- **Markov-Switching VECM** for capturing regime-dependent dynamics
- **Gaussian Mixture Hidden Markov Model (GMHMM)** for modeling non-linearity
- **Two-state regime detection** to identify market regimes (normal vs. crisis/structural break)

## 🎯 Research Objectives

- Overcome the linearity assumption in traditional cointegration analysis
- Detect regime switches in exchange rate markets
- Model non-linear long-run equilibrium relationships
- Provide empirical evidence for regime-dependent cointegration

## 📊 Methodology

### Phase 1: Data Analysis & Exploratory Tests (R)
Statistical tests performed using R/R-Studio:
- **Normality Tests**: Anderson-Darling, Jarque-Bera
- **Correlation Analysis**: Spearman's rank correlation, Kendall's tau, Johansen cointegration tests
- **Time Series Properties**: Stationarity tests, unit root detection

### Phase 2: Non-Linear Modeling (Python)
Implementation of the hybrid MS-VECM framework:
- **Gaussian Mixture Hidden Markov Model** for regime identification
- **Two-state regime classification** to account for non-linearity
- Vector error correction dynamics within each regime
- Out-of-sample validation and performance metrics

## 🛠️ Tech Stack

| Language | Usage | Percent |
|----------|-------|---------|
| **TeX** | Research paper, documentation | 85.3% |
| **R** | Statistical analysis, exploratory tests | 14.2% |
| **Python** | MS-VECM implementation, modeling | 0.5% |

## 📁 Repository Structure

```
├── README.md                    # This file
├── paper/                       # Research paper (TeX)
├── analysis/                    # R scripts for exploratory analysis
│   ├── normality_tests.R
│   ├── correlation_analysis.R
│   └── unit_root_tests.R
├── models/                      # Python implementation
│   ├── ms_vecm.py              # MS-VECM model class
│   ├── gmhmm.py                # Gaussian Mixture HMM implementation
│   └── validation.py           # Model validation scripts
├── data/                        # Exchange rate datasets
└── results/                     # Output figures, tables, metrics
```

## 🚀 Getting Started

### Prerequisites
- Python 3.8+
- R 4.0+
- Required packages: see `requirements.txt` (Python) and `packages.R` (R)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ithuteng17/A-non-linear-cointegration-approach.git
   cd A-non-linear-cointegration-approach
   ```

2. **Install Python dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Install R packages** (if running analysis)
   ```r
   source("packages.R")
   ```

### Quick Start

**Run MS-VECM analysis:**
```python
from models.ms_vecm import MarkovSwitchingVECM
from models.gmhmm import GaussianMixtureHMM

# Load and prepare data
model = MarkovSwitchingVECM(n_regimes=2)
model.fit(exchange_rate_data)
predictions = model.predict()
```

## 📈 Key Findings

- Non-linear cointegration relationships are statistically significant in exchange rate data
- Two regimes successfully capture market dynamics and structural breaks
- MS-VECM outperforms linear VECM in out-of-sample forecasting
- Regime-switching probabilities correlate with macroeconomic events

## 📚 References & Theory

- Johansen, S. (1988). Statistical Analysis of Cointegration Vectors. *Journal of Economic Dynamics and Control*
- Hamilton, J. D. (1989). A New Approach to the Economic Analysis of Nonstationary Time Series
- Guidolin, M., & Timmermann, A. (2007). Asset Allocation Under Multivariate Regime Switching

## 📄 Citation

If you use this research in your work, please cite:

```bibtex
@research{NonlinearCointegration2024,
  author = {Your Name},
  title = {Non-Linear Cointegration Approach: MS-VECM for Exchange Rates},
  year = {2024},
  url = {https://github.com/Ithuteng17/A-non-linear-cointegration-approach}
}
```

## ✉️ Contact & Collaboration

For questions, suggestions, or collaboration opportunities:
- **GitHub Issues**: [Open an issue](https://github.com/Ithuteng17/A-non-linear-cointegration-approach/issues)
- **Email**: [Your Email]

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Advisors and committee members for guidance
- Data providers for exchange rate datasets
- Open-source community (numpy, scipy, sklearn, statsmodels)

---

**Last Updated**: October 2024  
**Status**: Active Research
