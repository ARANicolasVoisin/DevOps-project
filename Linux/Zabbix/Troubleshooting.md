# Troubleshooting

---

## Serveur Zabbix n’est pas en cours d’execution

### Problème

Le serveur zabbix n'est plus accèssible.

Dans les logs de mariadb l'utilisateur de la base de donnée zabbix ne peux plus se connecter. En lisant les logs de zabbix on voit : pas assez de free chunk size

### Solution

Dans le fichier de configuration /etc/zabbix/zabbix_server.conf modifier le paramètre CacheSize et l'augmenter au moins jusqu'à 4 voir 5G.

---

## Erreur “Utilization of internal poller processes over 75%”

Si l'erreur se présente, il faut modifier les lignes suivantes dans le fichier /etc/zabbix/zabbix-server.conf : 

```bash
StartPollers=20
StartPollersUnreachable=5
```

---

## Erreur “Utilization of housekeeper processes over 75%”

Si cette erreur apparait, il faut modifier ces 2 lignes dans le ficher /etc/zabbix/zabbix-server.conf :

```bash
HousekeepingFrequency=1
MaxHousekeeperDelete=550000
```

---

## Erreur cache zabbix utilisé à 95%

Quand cette erreur est visible sur le serveur zabbix il faut modifier le fichier de configuration suivant :
/etc/zabbix/zabbix_server.conf.

Il faut rajouter du cache sur les lignes suivantes :

```bash
CacheSize=
ValueCacheSize= 
```

⚠️Attention cependant à ne pas mettre une trop grosse valeur sous peine de gros ralentissement, mieux vaux augmenter petit à petit.

---

## Base de données pleine

### Suppression, création, copie et suppression de l’ancienne base

Attention de bien modifier la valeur numérique (timeswamp) à la date souhaitée.

```sql
CREATE TABLE history_uint_new LIKE history_uint;
INSERT INTO history_uint_new SELECT * FROM history_uint WHERE clock > '1764751133'; # Transposer le timestanp unix sur la date du jour
ALTER TABLE history_uint RENAME history_uint_old;
ALTER TABLE history_uint_new RENAME history_uint;
DROP TABLE history_uint_old;
UPDATE items SET history = '15' WHERE history > '30';
```

### Suppression du contenu des tables SQL

Ces commandes supprimes les données antérieures à 7 jours.

```sql
delete FROM alerts where age(to_timestamp(alerts.clock)) > NOW() - INTERVAL 7 DAY;
DELETE FROM acknowledges WHERE FROM_UNIXTIME(clock) < NOW() - INTERVAL 7 DAY;
delete FROM events WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM history WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM history_uint WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM history_str  WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM history_text WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM history_log WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM trends WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
delete FROM trends_uint WHERE FROM_UNIXTIME(clock) > NOW() - INTERVAL 7 DAY;
```

Une fois la suppression faite, il faut utiliser les commandes suivantes sur chaque tables car celles ci sont défragmentées :

```sql
# Exemple pour la table history_uint
optimize table history_uint;
analyze table history_uint;
```

### Voir la place prise sur chaque table :

```sql
SELECT
        table_schema AS "Schema",
        table_name AS "Table",
        ROUND((data_length/1048576),2) AS "Data Size (MB)",
        ROUND((index_length/1048576),2) AS "Index Size (MB)",
        ROUND(((data_length+index_length)/1048576),2) AS "Total Size (MB)",
        ROUND((data_free/1048576),2) AS "Size Free (MB)"
FROM
        information_schema.tables
WHERE
        table_schema NOT IN ('performance_schema','information_schema','mysql')
ORDER BY
        (data_length+index_length) DESC
LIMIT 10;
```