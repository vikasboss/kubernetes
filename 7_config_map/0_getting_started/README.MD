# Getting Started with ConfigMaps

## Introduction
In the realm of Kubernetes, managing configurations effectively across different environments is crucial for maintaining consistency and flexibility. Configurations often vary based on the environment in which an application is deployed, such as production, staging, or development. To address this challenge, Kubernetes offers a resource called ConfigMaps.

## What are ConfigMaps?
ConfigMaps in Kubernetes provide a way to decouple configuration settings from the application code. They allow you to store configuration data in key-value pairs or as plain text files, which can then be injected into pods as environment variables or mounted as files within the container filesystem.

## Changing our Sample App
To illustrate the usage of ConfigMaps, let's enhance our sample application, hellok8s, by incorporating environment variables for dynamic configuration. We'll create version 4 (v4) of our application, where the message to be displayed is determined by an environment variable.

```ruby
require "sinatra"

set :bind, "0.0.0.0"

get "*" do
  message = ENV.fetch("MESSAGE", "Hello, Kubernetes")
  "[v4] #{message} (from #{`hostname`.strip})\n"
end
```

In this updated version, the application retrieves the value of the `MESSAGE` environment variable and uses it to customize the displayed message. If the `MESSAGE` variable is not set, it defaults to "Hello, Kubernetes".

## Cleaning Up Previous Resources
To ensure a clean slate for our examples, we can delete any existing resources by executing the following command:

```bash
kubectl delete deployment,service,ingress --all
```

This removes all previously created deployments, services, and ingresses, allowing us to start fresh with our new configuration.

Stay tuned as we explore how to create and use ConfigMaps in Kubernetes to manage application configurations seamlessly across different environments.
```

This README provides an overview of ConfigMaps in Kubernetes and outlines how to enhance a sample application using environment variables for dynamic configuration. It also includes instructions for cleaning up existing resources before proceeding with the examples.