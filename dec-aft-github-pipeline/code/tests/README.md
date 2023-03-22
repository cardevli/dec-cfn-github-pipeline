# Terratest - work in progress

## Configure and run Terratest

The following steps can be used to configure Go lang and run Terratests locally(Mac/Windows machine)).

__Note:__ Each test file must end with `` _test.go ``.

### Step 1: Install

[golang](https://go.dev/doc/install) (for macos you can use brew)

### Step 2: Change directory into the test folder.

```sh
cd tests
```

### Step 3: Initialize your test

```sh
 # Amazon corporate network only
 go env -w GOPROXY=direct

 go mod init "<MODULE_NAME>"
#  go mod init dec-project-template-terraform

 go mod tidy

```

### Step 4: Build and Run Test

```sh

go test -v -timeout 60m -tags=e2e
```

## References

* [Terratest best practices](https://terratest.gruntwork.io/docs/testing-best-practices/namespacing/)
* [Terratest examples](https://github.com/gruntwork-io/terratest/tree/master/test)
* <https://terratest.gruntwork.io/docs/getting-started/quick-start/>
