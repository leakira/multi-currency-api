[![CircleCI](https://circleci.com/gh/leakira/multi-currency-api.svg?style=svg)](https://circleci.com/gh/leakira/multi-currency-api)

# MultiCurrency
API to multiple currency convertion

## Test using
http://multi-currency-api.herokuapp.com

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

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
