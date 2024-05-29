import random
from faker import Faker
from datetime import datetime
import psycopg2
import os
from dotenv import load_dotenv
load_dotenv()

HOSTNAME = os.getenv('DB_HOSTNAME')
USERNAME = os.getenv('DB_USERNAME')
PASSWORD = os.getenv('DB_PASSWORD')
DATABASE = os.getenv('DB_DATABASE')

connection = psycopg2.connect(
    host=HOSTNAME, user=USERNAME, password=PASSWORD, dbname=DATABASE)


class DbConnection:
    @staticmethod
    def execute_change(query, values):
        cursor = connection.cursor()
        cursor.execute(query, values)
        connection.commit()
        cursor.close()

    @staticmethod
    def execute_select(query, values=None):
        cursor = connection.cursor()
        if values:
            cursor.execute(query, values)
        else:
            cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        return results


class TableModification():
    def __init__(self, table_name, column_names):
        self.table_name = table_name
        self.column_names = column_names

    def save(self, values):
        query = f'INSERT INTO {self.table_name} ({
            ", ".join(self.column_names)}) VALUES ({", ".join(['%s' for _ in range(len(self.column_names))])})'
        print(query)
        DbConnection.execute_change(query, values)

    def delete(self, input_id):
        query = f'DELETE FROM {self.table_name} WHERE id={input_id}'
        DbConnection.execute_change(query, (input_id))

    def select(self, input_id):
        query = f"SELECT * from {self.table_name} WHERE id={input_id}"
        DbConnection.execute_select(query)

    def get_items_list(self, fields=None, where=None, order_by=None):
        fields = fields if fields else self.column_names
        query = f"SELECT {", ".join(fields)} from {self.table_name}"
        if where:
            query += f' WHERE={where}'
        if order_by:
            query += f' ORDER BY {order_by[0]} {order_by[-1]}'
        res = DbConnection.execute_select(query)
        return res

    def get_item(self, input_id):
        query = f"SELECT * from {self.table_name} WHERE id={input_id}"
        res = DbConnection.execute_select(query)
        return res

    def update(self, values, input_id):
        query = f"UPDATE {
            self.table_name} SET {",".join([i+"=%s" for i in self.column_names])},update_date=NOW() WHERE {self.table_name}.id={input_id}"
        DbConnection.execute_change(query, values)

    def status_update(self, values):
        query = f"UPDATE {
            self.table_name} SET status_id=%s WHERE id=%s"
        DbConnection.execute_change(query, values)


class UsersModification(TableModification):
    def __init__(self):
        super().__init__(table_name="users", column_names=[
            "name", "last_name", "phone", "address", "email", "role_id", "password", "user_name"])

    def onLogin(self, login, password):
        query = f"select user_name, password from users where user_name='{
            login}' and password='{password}' and role_id=1"
        res = DbConnection.execute_select(query)
        if len(res) > 0:
            return True
        return False


class DealsModification(TableModification):
    def __init__(self):
        super().__init__(table_name="deals", column_names=[
            "deal_dscription", "client_id", "manager_id", "status_id"])

    def get_details(self, deal_id):
        q1 = "SELECT d.id, "
        q2 = "(u_client.name || ' ' || u_client.last_name) AS client_full_name,"
        q3 = "u_client.phone AS client_phone,"
        q4 = "u_client.address AS client_address,"
        q5 = "u_client.email AS client_email,"
        q6 = "CONCAT(u_manager.name, ' ', u_manager.last_name) AS manager_name,"
        q7 = "s.status_name, to_char(create_date, 'YYYY-MM-DD HH24:MI:SS') AS date_string"
        q8 = " FROM deals d INNER JOIN users u_client ON d.client_id = u_client.id INNER JOIN users u_manager ON d.manager_id = u_manager.id  INNER JOIN status s ON d.status_id = s.id"
        q9 = f" WHERE d.id = {deal_id}"
        query = q1+q2+q3+q4+q5+q6+q7+q8+q9
        res = DbConnection.execute_select(query)[0]
        return res

    def get_comments(self, deal_id):
        query = f"SELECT comment from comments where deal_id={deal_id}"
        res = DbConnection.execute_select(query)
        return res

    # def get_details_extra(self, deal_id):
    #     q1 = "SELECT d.id,"
    #     q2 = "(u_client.name || ' ' || u_client.last_name) AS client_full_name,"
    #     q3 = "u_client.phone AS client_phone,"
    #     q4 = "u_client.address AS client_address,"
    #     q5 = "u_client.email AS client_email,"
    #     q6 = "CONCAT(u_manager.name, ' ', u_manager.last_name) AS manager_name,"
    #     q7 = "(SELECT array_to_string(array_agg(c.comment), '/// ') FROM comments c WHERE c.deal_id = d.id) AS all_comments"
    #     q8 = " FROM deals d INNER JOIN users u_client ON d.client_id = u_client.id INNER JOIN users u_manager ON d.manager_id = u_manager.id  INNER JOIN status s ON d.status_id = s.id"
    #     q9 = f" WHERE d.id = {deal_id}"
    #     query = q1+q2+q3+q4+q5+q6+q7+q8+q9
    #     res = DbConnection.execute_select(query)
    #     return res


class ComentsModification(TableModification):
    def __init__(self):
        super().__init__(table_name="comments",
                         column_names=["deal_id", "user_id", "comment"])


fake = Faker()

clients = UsersModification()
# for i in range(50):
#     clients.save((fake.first_name(), fake.last_name(), fake.phone_number(), fake.address(
#     ), fake.email(), 2, fake.password(), fake.user_name()))

deal = DealsModification()
# for i in range(100):
#     deal.save((fake.text(), random.randint(3, 37), 1, 1))

# print(clients.get_items_list())
# print(clients.get_item(3))
# clients.delete(2)
deal.update(['hello', 10, 1, 2], 5)
print("first option")
print(deal.get_details(10))
print("comments", deal.get_comments(10))
# print("second option")
# print(deal.get_details_extra(5))

# comments = ComentsModification()
# for i in range(100):
#     comments.save((random.randint(1, 100), random.randint(3, 37),fake.text()))

# statuses = TableModification("status", ("id", "status_name"))
# s = statuses.get_items_list()
# print(s)
# clients.onLogin()
