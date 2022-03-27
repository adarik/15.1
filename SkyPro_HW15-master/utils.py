import sqlite3
import json


def get_data_from_db(db_name, query):
    """
    Функция производит выборку из базы данных, согласно запросу. Может возвращать только одно значение (fetchone).
    :param db_name: Имя файла с базой данных.
    :param query: Запрос в базу данных.
    :return: Json-формат, с наименованием колонок в качестве ключей и данными в качестве значений.
    """
    with sqlite3.connect(db_name) as connection:
        connection.row_factory = sqlite3.Row
        cursor = connection.cursor()
        cursor.execute(query)
        result = dict(cursor.fetchone())

        return json.dumps(result)
