# MultiCurrency

[![CircleCI](https://circleci.com/gh/leakira/multi-currency-api.svg?style=svg&circle-token=5ab05979cf9f875f0533e9644ced0e39cfff490b)](https://circleci.com/gh/leakira/multi-currency-api)
[![Github: @leakira](https://img.shields.io/badge/contact-@leakira-blue.svg?style=flat)](https://github.com/leakira)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/leakira/multi-currency-api/blob/master/LICENSE)

API to multiple currency conversion

## Test using
### API on Heroku
http://multi-currency-api.herokuapp.com

### iOS Shortcut
https://www.icloud.com/shortcuts/a0a07e74e2a345ac8772c44ca7f49f05

## Endpoints
- /currency: Get list of all available currencies to convert wth each description
- /currency/names: Get list of the name of all available currencies
- /plugins: Get list of currenct available plugins
- /convert/: Make conversion

## To convert
- **Value**: value to calculate
- **?from**: base currency (ex: USD)
- **?to** (optional): target currencies to convert. Need to pass by comma if has more than one (ex: EUR,JPY). If not exists, convert with all available currency
- **?use** (optional): use custom plugin. By default use free_currency_converter

## Examples
### Convert 55 USD to BRL, JPY, EUR
```
/convert/55?from=USD&to=BRL,JPY,EUR
```

### Convert 55 USD to BRL, JPY, EUR using CurrencyLayer API
```
/convert/55?from=USD&to=BRL,JPY,EUR&use=currency_layer
```

### Convert 55 USD to all available currencies
```
/convert/55?from=USD
```

## Configure for personal use
Edit .env setting:
- DEFAULT_PLUGIN: default plugin to convert if ?use is omitted
- CURRENCY_CONVERTER_TOKEN: CurrencyConverter API key
- CURRENCY_LAYER_TOKEN: CurrencyLayer API key

## Tools used to develop
- Ruby
- Sinatra

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
