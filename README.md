# terraform-aws-practice

Terraformin state-säilö omille AWS-projekteilleni. Tämä projekti luo S3-bucketin, johon muiden Terraform-projektien state tallennetaan. Ensimmäinen käyttäjä on [Anturi API](https://github.com/waltterir/ANTURI-API), jonka koko AWS-infra on koodina.

## Mitä tämä luo

- **S3-bucket** Terraformin state-tiedostoille
- **Versiointi**: jokainen apply tallentaa uuden version statesta, joten vanhaan voi palata, jos state rikkoutuu
- **Julkisen pääsyn esto**: statessa voi olla arkaluontoista tietoa, joten bucket ei voi koskaan muuttua julkiseksi

Myös tämän projektin oma state on samassa bucketissa (`terraform-aws/terraform.tfstate`). Aluksi state oli paikallinen tiedosto, ja siirsin sen S3:een, kun bucket oli luotu.

## Miksi erillinen projekti

Sovellusten infraa luodaan ja puretaan usein kustannussyistä, mutta state-bucketia ei pureta koskaan. Jos bucket olisi samassa projektissa kuin sovellus, jokainen `terraform destroy` yrittäisi poistaa myös sen bucketin, johon projektin oma state on tallennettu.

## Käyttö muissa projekteissa

Jokainen projekti käyttää samaa bucketia omalla keyllään:

```hcl
terraform {
  backend "s3" {
    bucket       = "waltteri-tf-test-bucket"
    key          = "anturi-api/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }
}
```

`use_lockfile` estää kahta ajoa muuttamasta statea samanaikaisesti.

## Mitä opin tässä projektissa

Terraformin peruskierto (`init`, `plan`, `apply`, `destroy`), staten toiminta, drift, resurssin uudelleennimeäminen `moved`-lohkolla, staten siirto paikallisesta S3:een ja jumittuneen state-lukon purku.
