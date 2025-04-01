# pod-debug

# build

```bash
docker build -t pod-debug
```

# use

```bash
kubectl -n test-ns debug -it test-demo --image=pod-debug --target=test-demo
```
