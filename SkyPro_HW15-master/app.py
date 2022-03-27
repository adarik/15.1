from flask import Flask
from utils import get_data_from_db

app = Flask(__name__)


@app.route('/<itemid>')
def get_data(itemid):
    query = f"""
        SELECT animals_normal.id,
        age,
        animals_normal.animal_id,
        type,
        name,
        breed,
        color_1,
        color_2,
        date_of_birth,
        outcome.program,
        outcome.status,
        outcome.coming_month,
        outcome.coming_year
        FROM animals_normal
        INNER JOIN outcome ON animals_normal.animal_id = outcome.animal_id
        WHERE animals_normal.id = '{itemid}'
        """

    return get_data_from_db('animal.db', query)


if __name__ == '__main__':
    app.run()
