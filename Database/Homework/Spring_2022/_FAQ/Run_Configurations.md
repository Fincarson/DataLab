# Run Configurations

以下列出常用的 Run Configurations，通常直接複製貼上就可以使用。

## VanillaDB Core Server

#### Main Class: `org.vanilladb.core.server.StartUp`

#### Program Arguments

Format:
```
[Database Directory Name]
```
Example:
```
TestDB
```

#### VM Arguments

```
-Djava.util.logging.config.file=target/classes/java/util/logging/logging.properties
-Dorg.vanilladb.core.config.file=target/classes/org/vanilladb/core/vanilladb.properties
```

## Benchamrk Server

#### Main Class: `org.vanilladb.bench.server.StartUp`

#### Program Arguments

Format:
```
[Database Directory Name]
```
Example:
```
BenchDB
```

#### VM Arguments

```
-Djava.util.logging.config.file=target/classes/java/util/logging/logging.properties
-Dorg.vanilladb.bench.config.file=target/classes/org/vanilladb/bench/vanillabench.properties
-Dorg.vanilladb.core.config.file=target/classes/org/vanilladb/core/vanilladb.properties
```


## Benchmark Client

#### Main Class: `org.vanilladb.bench.App`

#### Program Arguments

Format:
```
[Action](1 = Loading Testbed, 2 = Benchmarking)
```
Example:
```
1
```

#### VM Arguments

```
-Djava.util.logging.config.file=target/classes/java/util/logging/logging.properties
-Dorg.vanilladb.bench.config.file=target/classes/org/vanilladb/bench/vanillabench.properties
-Dorg.vanilladb.core.config.file=target/classes/org/vanilladb/core/vanilladb.properties
```

## ElaSQLBench Server

#### Script
```sh
java \
-Dorg.elasql.config.file=elasql.properties \
-Dorg.elasql.bench.config.file=elasqlbench.properties \
-Dorg.vanilladb.comm.config.file=vanilladbcomm.properties \
-Dorg.vanilladb.bench.config.file=vanillabench.properties \
-Dorg.vanilladb.core.config.file=vanilladb.properties \
-Djava.util.logging.config.file=logging.properties \
-jar server.jar \
$1 \
$2 \
$3 \
```

## ElaSQLBench Client

#### Script
```sh
java \
-Dorg.elasql.config.file=elasql.properties \
-Dorg.elasql.bench.config.file=elasqlbench.properties \
-Dorg.vanilladb.comm.config.file=vanilladbcomm.properties \
-Dorg.vanilladb.bench.config.file=vanillabench.properties \
-Dorg.vanilladb.core.config.file=vanilladb.properties \
-Djava.util.logging.config.file=logging.properties \
-jar client.jar \
$1 \
$2 \
```
