# Buzzr Terraform Dev

## Overview

This is the Terraform repo for AWS Dev account. Changes made here only affect Buzzr dev account

This repo utilizes github actions that will run `terraform plan` on every pull request to provide a view of all the changes that will be made.

Make sure that all pipelines pass and `terraform plan` returns the expected changes that you are looiking for

## Layout

```
<region>/
    <service>
```

use `global` for any config that will apply globally to all aws accounts.. i.e route 53 records
