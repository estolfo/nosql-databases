from neo4j.v1 import GraphDatabase

uri = "bolt://localhost:7474"
driver = GraphDatabase.driver(uri)

def print_friends_of(name):
    with driver.session() as session:
        with session.begin_transaction() as tx:
            for record in tx.run("MATCH (a:Person)-[:KNOWS]->(f) "
                                 "WHERE a.name = {name} "
                                 "RETURN f.name", name=name):
                print(record["f.name"])

print_friends_of("Alice")