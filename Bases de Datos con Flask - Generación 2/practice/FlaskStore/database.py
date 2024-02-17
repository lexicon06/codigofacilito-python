from peewee import MySQLDatabase, Model, DecimalField, IntegerField, CharField
from os import environ


db = MySQLDatabase(
    database=environ.get("DB_NAME"),
    user=environ.get("DB_USER"),
    password=environ.get("DB_PASSWORD"),
    port=int(environ.get("DB_PORT")),
    host=environ.get("DB_HOST")
)


class User(Model):
    UserID = IntegerField(primary_key=True)
    Email = CharField(max_length=100)
    Password = CharField(max_length=100)
    FirstName = CharField(max_length=100)
    LastName = CharField(max_length=100)

    class Meta:
        database = db
        db_table = "Users"

    @classmethod
    def create_user(cls, _email, _password):
        _password = "storeFlask_" + _password
        return User.create(Email=_email, Password=_password)
    @classmethod
    def login_user(cls, _email, _password):
        try:
            user = User.get(User.Email == _email, User.Password == _password)
            return user
        except User.DoesNotExist:
            return None


class Product(Model):
    ProductID = IntegerField(primary_key=True)
    ProductName = CharField(max_length=100)
    Price = DecimalField(max_digits=10, decimal_places=2)
    photoUrl = CharField(max_length=255)

    class Meta:
        database = db
        db_table = "Products"

    @property
    def price_format(self):
        return f"$ {self.Price} dollars"
    @classmethod
    def add_product(cls, _name, _price, _photo):
        return Product.create(ProductName = _name, Price = _price, photoUrl = _photo)
    @classmethod
    def display_products(cls):
        try:
            products = cls.select()
            return list(products)
        except Exception as e:
            print(f'We have a problem {e}')

        






db.create_tables([User, Product])
