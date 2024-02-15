from peewee import MySQLDatabase, Model, DecimalField, IntegerField, CharField
from environ import Environ


env = Environ()
env.read_env()

db = MySQLDatabase(
    env.get("DB_NAME"),
    user=env.get("DB_USER"),
    password=env.get("DB_PASSWORD"),
    port=int(env.get("DB_PORT")),
    host=env.get("DB_HOST")
)


class User(Model):
    UserID = IntegerField(primary_key=True)
    Email = CharField(max_length=100)
    Password = CharField(max_length=100)

    class Meta:
        database = db
        db_table = "Users"

    @classmethod
    def create_user(cls, _email, _password):
        _password = "storeFlask_" + _password
        return User.create(Email=_email, Password=_password)


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



db.create_tables([User, Product])
