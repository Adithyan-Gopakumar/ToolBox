from datetime import timedelta

from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt

app = Flask(__name__)
app.secret_key = 'eH6BjKbFtJg4yP0Q1rWXu89Zc2aVs7Y3sLhNopkD'

# Session configurations
app.permanent_session_lifetime = timedelta(days=7)  # Set session lifetime to 7 days

# MySQL configurations
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'toolbox'

mysql = MySQL(app)
bcrypt = Bcrypt(app)

# Pagination configuration
PER_PAGE = 12

@app.before_request
def make_session_permanent():
    session.permanent = True

@app.route('/')
def home():
    cur = mysql.connection.cursor()

    cur.execute("SELECT image_url FROM carousel")
    carousel_images = cur.fetchall()

    cur.execute("SELECT id, title, discount, price, image_url FROM tools")
    tools = cur.fetchall()

    cur.execute("SELECT image_url FROM offers")
    offers = cur.fetchall()

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()

    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()

    cur.close()

    user_name = session.get('user_name')

    return render_template('Homepage.html', carousel_images=carousel_images, tools=tools, offers=offers,
                           categories=categories, brands=brands, user_name=user_name)

@app.route('/search')
def search():
    query = request.args.get('query')
    page = int(request.args.get('page', 1))  # Get the current page
    start_index = (page - 1) * PER_PAGE  # Calculate the start index for pagination

    cur = mysql.connection.cursor()
    search_query = f"%{query}%"
    cur.execute("SELECT id, title, discount, price, image_url FROM tools WHERE title LIKE %s", (search_query,))
    tools = cur.fetchall()

    # Get the total number of tools matching the search query for pagination
    cur.execute("SELECT COUNT(*) FROM tools WHERE title LIKE %s", (search_query,))
    total_tools = cur.fetchone()[0]

    # Calculate the total number of pages
    total_pages = (total_tools + PER_PAGE - 1) // PER_PAGE

    # Limit the tools for the current page
    cur.execute("SELECT id, title, discount, price, image_url FROM tools WHERE title LIKE %s LIMIT %s OFFSET %s",
                (search_query, PER_PAGE, start_index))
    tools = cur.fetchall()

    # Fetch categories and brands for navbar
    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()

    cur.close()


    return render_template('List.html', tools=tools, categories=categories, brands=brands, page=page,
                           total_pages=total_pages, sort_by='price', order='asc', user_name=session.get('user_name') ) # Add default sort parameters

@app.route('/category/<int:category_id>')
def list_by_category(category_id):
    page = int(request.args.get('page', 1))
    sort_by = request.args.get('sort_by', 'price')
    order = request.args.get('order', 'asc')

    start_index = (page - 1) * PER_PAGE
    cur = mysql.connection.cursor()

    sort_query = f"ORDER BY {sort_by} {order}"
    cur.execute(f"SELECT id, title, discount, price, image_url, rating FROM tools WHERE category_id = %s {sort_query} LIMIT %s OFFSET %s",
                (category_id, PER_PAGE, start_index))
    tools = cur.fetchall()

    cur.execute("SELECT COUNT(*) FROM tools WHERE category_id = %s", (category_id,))
    total_tools = cur.fetchone()[0]

    total_pages = (total_tools + PER_PAGE - 1) // PER_PAGE

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()
    cur.close()

    return render_template('List.html', tools=tools, categories=categories, brands=brands, page=page,
                           total_pages=total_pages, sort_by=sort_by, order=order, current_category=category_id, user_name=session.get('user_name'))

@app.route('/brand/<int:brand_id>')
def list_by_brand(brand_id):
    page = int(request.args.get('page', 1))
    sort_by = request.args.get('sort_by', 'price')
    order = request.args.get('order', 'asc')

    start_index = (page - 1) * PER_PAGE
    cur = mysql.connection.cursor()

    sort_query = f"ORDER BY {sort_by} {order}"
    cur.execute(f"SELECT id, title, discount, price, image_url, rating FROM tools WHERE brand_id = %s {sort_query} LIMIT %s OFFSET %s",
                (brand_id, PER_PAGE, start_index))
    tools = cur.fetchall()

    cur.execute("SELECT COUNT(*) FROM tools WHERE brand_id = %s", (brand_id,))
    total_tools = cur.fetchone()[0]

    total_pages = (total_tools + PER_PAGE - 1) // PER_PAGE

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()
    cur.close()

    return render_template('List.html', tools=tools, categories=categories, brands=brands, page=page,
                           total_pages=total_pages, sort_by=sort_by, order=order, current_brand=brand_id, user_name=session.get('user_name'))

@app.route('/item/<int:item_id>', methods=['GET', 'POST'])
def item_details(item_id):
    if request.method == 'POST':
        review_name = request.form['review_name']
        rating = request.form['rating']
        review_text = request.form['review_text']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO reviews (tool_id, r_name, rating, review_text) VALUES (%s, %s, %s, %s)",
                    (item_id, review_name, rating, review_text))
        mysql.connection.commit()
        cur.close()


        return redirect(url_for('item_details', item_id=item_id))

    cur = mysql.connection.cursor()
    cur.execute("SELECT id, title, discount, price, image_url, rating, description FROM tools WHERE id = %s",
                (item_id,))
    tool = cur.fetchone()

    cur.execute("SELECT r_name, rating, review_text FROM reviews WHERE tool_id = %s", (item_id,))
    reviews = cur.fetchall()

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()

    cur.close()

    return render_template('item_details.html', tool=tool, reviews=reviews, categories=categories, brands=brands,user_name=session.get('user_name'))

@app.route('/add_to_basket/<int:item_id>', methods=['POST'])
def add_to_basket(item_id):
    user_id = session.get('user_id')

    if not user_id:
        return redirect(url_for('login'))

    cur = mysql.connection.cursor()

    # Check if the item is in stock
    cur.execute("SELECT quantity FROM tools WHERE id = %s", (item_id,))
    tool = cur.fetchone()

    if tool and tool[0] > 0:

        cur.execute("INSERT INTO purchases (user_id, tool_id, purchase_date) VALUES (%s, %s, NOW())",
                    (user_id, item_id))

        #
        cur.execute("UPDATE tools SET quantity = quantity - 1 WHERE id = %s", (item_id,))
        mysql.connection.commit()

        flash('Item added to your cart!', 'success')
    else:
        flash('Sorry, this item is out of stock.', 'danger')

    cur.close()
    return redirect(url_for('item_details', item_id=item_id))

@app.route('/services')
def services():
    cur = mysql.connection.cursor()
    cur.execute("SELECT id,name, description, icon FROM services")
    services = cur.fetchall()
    cur.close()
    return render_template('Services.html', services=services, user_name=session.get('user_name'))


@app.route('/service_booking/<service_id>', methods=['GET', 'POST'])
def service_booking(service_id):
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone_number = request.form['phone']
        address = request.form['address']
        problem_description = request.form['problem']
        appointment_date = request.form['appointment-date']
        appointment_time = request.form['appointment-time']

        cur = mysql.connection.cursor()

        # Check if the user is logged in
        user_id = session.get('user_id')

        # Fetch the service name from the database
        cur.execute("SELECT name FROM services WHERE id = %s", (service_id,))
        service_name = cur.fetchone()[0]

        cur.execute(
            "INSERT INTO bookings (user_id, service_id, service_name, name, email_id, address, phone_number, problem_description, appointment_date, appointment_time) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
            (user_id, service_id, service_name, name, email, address, phone_number, problem_description, appointment_date, appointment_time)
        )
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('services'))

    # Fetch user details if logged in
    user_details = {}
    if 'user_id' in session:
        cur = mysql.connection.cursor()
        cur.execute("SELECT name, email_id, phone_number, address FROM users WHERE user_id = %s", (session['user_id'],))
        user_details = cur.fetchone()
        cur.close()

    cur = mysql.connection.cursor()
    cur.execute("SELECT name FROM services WHERE id = %s", (service_id,))
    service = cur.fetchone()
    cur.close()
    service_name = service[0]

    return render_template('Service_booking.html', service=service_name, user_details=user_details,
                           user_name=session.get('user_name'))

@app.route('/rent')
def rent():
    cur = mysql.connection.cursor()

    category_id = request.args.get('category')
    brand_id = request.args.get('brand')
    rating = request.args.get('rating')
    min_price = request.args.get('min_price')
    max_price = request.args.get('max_price')
    page = request.args.get('page', 1, type=int)
    per_page = 12

    query = "SELECT * FROM rental_tools WHERE 1=1"
    params = []

    if category_id:
        query += " AND category_id = %s"
        params.append(category_id)
    if brand_id:
        query += " AND brand_id = %s"
        params.append(brand_id)
    if rating:
        query += " AND rating >= %s"
        params.append(rating)
    if min_price:
        query += " AND price >= %s"
        params.append(min_price)
    if max_price:
        query += " AND price <= %s"
        params.append(max_price)

    cur.execute(query, params)
    total_items = len(cur.fetchall())

    query += " LIMIT %s OFFSET %s"
    params.extend([per_page, (page - 1) * per_page])

    cur.execute(query, params)
    rental_tools = cur.fetchall()

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()

    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()

    cur.close()

    total_pages = (total_items + per_page - 1) // per_page

    return render_template('rent.html', rental_tools=rental_tools, categories=categories, brands=brands, page=page,
                           total_pages=total_pages,user_name=session.get('user_name'))

@app.route('/rent_details/<int:rtool_id>', methods=['GET', 'POST'])
def rent_details(rtool_id):
    if request.method == 'POST':
        review_name = request.form['review_name']
        rating = request.form['rating']
        review_text = request.form['review_text']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO r_reviews (rtool_id, r_name, rating, review_text) VALUES (%s, %s, %s, %s)",
                    (rtool_id, review_name, rating, review_text))
        mysql.connection.commit()
        cur.close()


        return redirect(url_for('rent_details', rtool_id=rtool_id))

    cur = mysql.connection.cursor()
    cur.execute("SELECT id, title, discount, price, image_url, rating, description FROM rental_tools WHERE id = %s",
                (rtool_id,))
    rental_tool = cur.fetchone()

    cur.execute("SELECT r_name, rating, review_text FROM r_reviews WHERE rtool_id = %s", (rtool_id,))
    reviews = cur.fetchall()


    user_details = {}
    if 'user_id' in session:
        cur.execute("SELECT name, email_id, phone_number, address FROM users WHERE user_id = %s", (session['user_id'],))
        user_details = cur.fetchone()

    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()

    cur.close()

    return render_template('rental_booking.html', rental_tool=rental_tool, reviews=reviews, categories=categories, brands=brands, user_details=user_details, user_name=session.get('user_name'))

@app.route('/book_rental/<int:rtool_id>', methods=['POST'])
def book_rental(rtool_id):
    user_id = session.get('user_id')
    user_details = {}
    if 'user_id' in session:
        cur = mysql.connection.cursor()
        cur.execute("SELECT name, email_id, phone_number, address FROM users WHERE user_id = %s", (session['user_id'],))
        user_details = cur.fetchone()
        cur.close()

    name = user_details[0] if user_details else request.form['name']
    email = user_details[1] if user_details else request.form['email']
    phone_number = user_details[2] if user_details else request.form['phone_number']
    address = user_details[3] if user_details else request.form['address']
    rental_date = request.form['rental_date']
    return_date = request.form['return_date']

    cur = mysql.connection.cursor()
    cur.execute(
        "INSERT INTO rentals (tool_id, user_id, name, email, phone_number, address, rental_date, return_date) "
        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
        (rtool_id, user_id, name, email, phone_number, address, rental_date, return_date)
    )
    mysql.connection.commit()
    cur.close()

    flash('Booking successful!', 'success')
    return redirect(url_for('rent_details', rtool_id=rtool_id))



@app.route('/cart')
def cart():
    user_id = session.get('user_id')
    if not user_id:
        flash('Please log in to view your cart.', 'danger')
        return redirect(url_for('login'))

    cur = mysql.connection.cursor()

    # Fetch rental history
    cur.execute("""
           SELECT rt.image_url, rt.title, rt.price, r.rental_date, r.return_date 
           FROM rentals r
           JOIN rental_tools rt ON r.tool_id = rt.id
           WHERE r.user_id = %s
       """, (user_id,))
    rentals = cur.fetchall()
    # Fetch service bookings
    cur.execute("""
            SELECT appointment_date, appointment_time, problem_description, service_name 
            FROM bookings
            WHERE user_id = %s
        """, (user_id,))
    service_bookings = cur.fetchall()
    # Fetch purchase history with item details
    cur.execute("""
        SELECT p.id, p.tool_id, p.purchase_date, t.title, t.price, t.image_url 
        FROM purchases p
        JOIN tools t ON p.tool_id = t.id
        WHERE p.user_id = %s
    """, (user_id,))
    purchases = cur.fetchall()

    cur.close()

    return render_template('cart.html', rentals=rentals, service_bookings=service_bookings, purchases=purchases)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email_id = request.form['email']
        dob = request.form['dob']
        address = request.form['address']
        phone_number = request.form['phno']
        password = request.form['password']
        confirm_password = request.form['confirmPassword']

        if password != confirm_password:
            flash('Passwords do not match', 'danger')
            return redirect(url_for('register'))

        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO users (name, email_id, dob, address, phone_number, password) VALUES (%s, %s, %s, %s, %s, %s)",
            (name, email_id, dob, address, phone_number, hashed_password))
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('login'))

    return render_template('Registration.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        cur = mysql.connection.cursor()
        cur.execute("SELECT user_id, name, password FROM users WHERE email_id = %s", (email,))
        user = cur.fetchone()
        cur.close()
        if user and bcrypt.check_password_hash(user[2], password):
            session.permanent = True  # Ensure the session is permanent
            session['user_id'] = user[0]
            session['user_name'] = user[1]
            return redirect(url_for('home'))


    return render_template('Login.html')


@app.route('/profile', methods=['GET', 'POST'])
def profile():
    user_id = session.get('user_id')

    if not user_id:
        flash('Please log in to view your profile.', 'danger')
        return redirect(url_for('login'))

    cur = mysql.connection.cursor()


    cur.execute("SELECT name, email_id, phone_number, address FROM users WHERE user_id = %s", (user_id,))
    user = cur.fetchone()

    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        address = request.form['address']


        cur.execute("""
            UPDATE users 
            SET name = %s, email_id = %s, phone_number = %s, address = %s 
            WHERE user_id = %s
        """, (name, email, phone_number, address, user_id))
        mysql.connection.commit()


        return redirect(url_for('profile'))

    cur.close()

    return render_template('profile.html', user=user, user_name=session.get('user_name'))

@app.route('/logout')
def logout():
    session.clear()

    return redirect(url_for('home'))


@app.route('/delete_profile', methods=['POST'])
def delete_profile():
    user_id = session.get('user_id')

    if not user_id:
        return redirect(url_for('login'))

    cur = mysql.connection.cursor()

    cur.execute("DELETE FROM bookings WHERE user_id = %s", (user_id,))
    cur.execute("DELETE FROM rentals WHERE user_id = %s", (user_id,))

    cur.execute("DELETE FROM purchases WHERE user_id = %s", (user_id,))

    cur.execute("DELETE FROM users WHERE user_id = %s", (user_id,))

    mysql.connection.commit()
    cur.close()
    session.clear()

    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True)
