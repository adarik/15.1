import pytest

from project.dao.genre import GenreDAO
from project.dao.models.genre import Genre


class TestGenreDAO:
    @pytest.fixture(autouse=True)
    def dao(self, db):
        self.dao = GenreDAO(db.session)

    @pytest.fixture
    def genre_1(self, db):
        g = Genre(name="Боевик")
        db.session.add(g)
        db.session.commit()
        return g

    @pytest.fixture
    def genre_2(self, db):
        g = Genre(name="Комедия")
        db.session.add(g)
        db.session.commit()
        return g

    def test_get_genre_by_id(self, genre_1):
        assert self.dao.get_one(genre_1.id) == genre_1

    def test_get_genre_by_id_not_found(self):
        assert self.dao.get_one(1) is None

    def test_get_all_genres(self, genre_1, genre_2):
        assert self.dao.get_all() == [genre_1, genre_2]

    def test_get_by_page(self):
        page = 2
        assert len(self.dao.get_by_page(page)) == 0