global u
import os

from cs50 import SQL
from datetime import date
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from datetime import datetime
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    ucc = db.execute("SELECT cash FROM users WHERE username = ?", u)
    stocks = db.execute("SELECT DISTINCT company FROM purchases WHERE username = ?", u)
    i = 0
    num = {}
    cp = {}
    tv = {}
    gt = ucc[0]["cash"]
    for stock in stocks:
        p1 = stocks[i]["company"]
        nosh = db.execute("SELECT SUM(nos) FROM purchases WHERE username = ? AND company = ?", u, p1)
        num[p1] = (int(nosh[0]["SUM(nos)"]))
        cp[p1] = lookup(p1)["price"]
        tv[p1] = round(num[p1] * cp[p1], 2)
        gt = gt + tv[p1]
        i = i + 1

    return render_template("index.html", ucc=round(ucc[0]["cash"],2), num=num, stocks=stocks, cp=cp, tv=tv, gt=round(gt, 2))


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "POST":
        symbol = request.form.get("symbol")
        shares = request.form.get("shares")
        try:
            money = lookup(symbol)["price"]
        except (TypeError):
            return apology("symbol does not exist", 403)
        if ((not symbol) or (int(shares) < 0)):
            return apology("gurlll", 403)
        cash = db.execute("SELECT cash FROM users WHERE username = ?", u)
        if (int(shares)*money > cash[0]["cash"]):
            return apology("You're Poor", 403)
        else:
            cash = cash[0]["cash"] - (int(shares)*money)
        db.execute("UPDATE users SET cash = ? WHERE username = ?", cash, u)
        db.execute("INSERT INTO purchases (username, month, date, year, company, nos) VALUES(?, ?, ?, ?, ?, ?)", u, date.today().month, date.today().day, date.today().year, lookup(symbol)["symbol"], shares)
        db.execute("INSERT INTO history (username, month, bos, date, time, company, nos, price) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", u, date.today().month, "bought", date.today().day, datetime.now(), lookup(symbol)["symbol"], shares, money)
        return redirect("/")
    else:
        return render_template("buy.html")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    history = db.execute("SELECT * FROM history WHERE username = ?", u)
    return render_template("history.html", history=history)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))
        global u
        u = request.form.get("username")
        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")

@app.route("/addcash", methods=["GET", "POST"])
def addcash():
    if request.method == "POST":
        cash = request.form.get("cash")
        cc = db.execute("SELECT cash FROM users WHERE username = ?", u)
        if (not cash) or (int(cash) < 0):
            return apology("GURL", 403)
        nc = int(cash) + int(cc[0]["cash"])
        db.execute("UPDATE users SET cash = ? WHERE username = ?", nc, u)
        return redirect("/")
    else:
        return render_template("addcash.html")



@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "POST":
        symbol = request.form.get("symbol")
        money = lookup(symbol)
        try:
            return render_template("quoted.html", money=money["price"])
        except (TypeError):
            return apology("symbol does not exist", 403)
    else:
        return render_template("quote.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "POST":
        username = request.form.get("username")
        if (username in db.execute("SELECT username FROM users")):
            return apology("username is taken", 403)
        elif not (username):
            return apology("must submit username", 403)
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")
        if ((not password) or (not confirmation)):
            return apology("must submit password/confirmation", 403)
        if password != confirmation:
            return apology("passwords do not match", 403)
        db.execute("INSERT INTO users (username, hash) VALUES(?, ?)", username, generate_password_hash(password))
        return redirect("/")
    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    if request.method == "POST":
        symbol = request.form.get("symbol")
        shares = request.form.get("shares")
        try:
            money = lookup(symbol)["price"]
        except (TypeError):
            return apology("symbol does not exist", 403)
        nosh = db.execute("SELECT SUM(nos) FROM purchases WHERE username = ? AND company = ?", u, symbol)
        if ((not symbol) or (int(shares) < 0) or (int(nosh[0]["SUM(nos)"]) < int(shares))):
            return apology("gurlll", 403)
        cash = db.execute("SELECT cash FROM users WHERE username = ?", u)
        cash = cash[0]["cash"] + int(shares)*money
        db.execute("UPDATE users SET cash = ? WHERE username = ?", cash, u)
        db.execute("INSERT INTO purchases (username, month, date, year, company, nos) VALUES(?, ?, ?, ?, ?, ?)", u, date.today().month, date.today().day, date.today().year, lookup(symbol)["symbol"], (0-int(shares)))
        db.execute("INSERT INTO history (username, month, bos, date, time, company, nos, price) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", u, date.today().month, "sold", date.today().day, datetime.now(), lookup(symbol)["symbol"], shares, money)
        return redirect("/")
    else:
        stocks = db.execute("SELECT DISTINCT company FROM purchases WHERE username = ?", u)
        return render_template("sell.html", stocks=stocks)
