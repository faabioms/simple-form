from flask_mysqldb import MySQL
from flask import Flask, request, jsonify

app = Flask(__name__)

app.config["MYSQL_HOST"] = "0.0.0.0"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "123123"
app.config["MYSQL_DB"] = "flaskapp"

mysql = MySQL(app)

html = """
<br><h2>Please, type your <i>Name</i>, favorite <i>color</i> and choose your <i>pet</i>:</h2>
<br>
<form method='POST' action='/'>
    Name: <input type='text' name='name' required="required"> <br>
    Color: <input type='text' name='color' required="required"> <br>
    Pet: <select name='pet' required>
            <option value=""> Select Pet</option>
            <option value="cat">Cat</option>
            <option value="dog">Dog</option>
        </select> <br>
    <br>
    <input type='submit'>
</form>
"""

@app.route('/', methods = ['GET', 'POST'])
def index():
    if request.method == 'POST':
        userDetails = request.form
        name = userDetails['name']
        color = userDetails['color']
        pet = userDetails['pet']
        cur = mysql.connection.cursor()
        try:
            cur.execute("INSERT INTO Customers(name, color, pet) VALUES (%s, %s, %s)",(name, color, pet))
            mysql.connection.commit()
            cur.close()
            return "Success, Welcome {}, your favorite color is {}, and you love {}s as I do".format(name, color, pet)
        except:
            return "You are already registered"
    return html

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=80)