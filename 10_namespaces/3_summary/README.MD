# Summary: How Namespaces Affect Service’s DNS

In this chapter, we explored how namespaces affect service's DNS in Kubernetes. Here's a recap of what we learned:

## Recap

- **Namespace Basics**: Most resources in Kubernetes live within a namespace. By default, unless explicitly defined otherwise, resources reside in the default namespace.
  
- **Organizational Tool**: Namespaces serve as an organizational tool, allowing us to segregate resources. However, they do not provide strong security boundaries between namespaces.
  
- **Creating Resources**: We learned that resources can be created in different namespaces by either specifying the namespace name in the manifest metadata or by using the `-n` flag when running `kubectl apply`.
  
- **Accessing Services**: Services in Kubernetes have DNS entries scoped by namespace. When accessing services from different namespaces, we use the full path `<service-name>.<namespace-name>`.

This chapter provided practical examples demonstrating how to create pods and services in different namespaces and how to access services across namespaces using their DNS entries.

```

This README provides a concise summary of the key points covered in the chapter on how namespaces affect service's DNS in Kubernetes.