# example

```
stack run
```

```
$ curl localhost:3000/item/0
{"itemId":0,"itemText":"Drew"}%
```

```
$ curl -v localhost:3000/item/1
* Host localhost:3000 was resolved.
...
< HTTP/1.1 404 Not Found
< Transfer-Encoding: chunked
< Date: Mon, 23 Dec 2024 15:23:24 GMT
< Server: Warp/3.3.31
```

```
$ curl localhost:3000/stream
{"itemId":2,"itemText":"Drew"}
{"itemId":4,"itemText":"Drew"}
{"itemId":6,"itemText":"Drew"}
{"itemId":8,"itemText":"Drew"}
{"itemId":10,"itemText":"Drew"}
{"itemId":12,"itemText":"Drew"}
{"itemId":14,"itemText":"Drew"}
{"itemId":16,"itemText":"Drew"}
{"itemId":18,"itemText":"Drew"}
{"itemId":20,"itemText":"Drew"}
```
