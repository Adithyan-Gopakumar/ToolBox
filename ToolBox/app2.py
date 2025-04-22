from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt

app = Flask(__name__)
app.secret_key = 'eH6BjKbFtJg4yP0Q1rWXu89Zc2aVs7Y3sLhNopkD'

# MySQL configurations
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'toolbox'

mysql = MySQL(app)
bcrypt = Bcrypt(app)

@app.route('/')
def admin_dashboard():
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()
    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, image_url FROM carousel")
    carousel = cur.fetchall()
    cur.execute("SELECT id, image_url FROM offers")
    offers = cur.fetchall()

    cur.close()
    return render_template('admin.html', brands=brands, categories=categories,carousel=carousel, offers=offers)




@app.route('/admin/carousel/add', methods=['GET', 'POST'])
def add_carousel():
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        image_url = request.form['image_url']
        category_id = request.form['category_id']
        brand_id = request.form['brand_id']

        cur.execute(
            "INSERT INTO carousel (image_url, category_id, brand_id) VALUES (%s, %s, %s)",
            (image_url, category_id, brand_id)
        )
        mysql.connection.commit()
        cur.close()

        flash('Carousel item added successfully!', 'success')
        return redirect(url_for('admin_dashboard'))

    # Fetch categories and brands for dropdowns
    cur.execute("SELECT id, name FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT id, name FROM brands")
    brands = cur.fetchall()
    cur.close()

    return render_template('Admin_add.html', categories=categories, brands=brands)

@app.route('/admin/carousel/delete/<int:carousel_id>', methods=['POST'])
def delete_carousel(carousel_id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM carousel WHERE id = %s", (carousel_id,))
    mysql.connection.commit()
    cur.close()

    flash('Carousel item deleted successfully!', 'success')
    return redirect(url_for('admin_dashboard'))


@app.route('/admin/offer', methods=['POST'])
def add_offer():
    image_url = request.form['offer_image']
    category_id = request.form['category_id']
    brand_id = request.form['brand_id']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO offers (image_url, category_id, brand_id) VALUES (%s, %s, %s)", (image_url, category_id, brand_id))
    mysql.connection.commit()
    cur.close()
    flash('Offer added successfully!', 'success')
    return redirect(url_for('admin_dashboard'))

@app.route('/admin/offer/delete/<int:id>', methods=['POST'])
def delete_offer(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM offers WHERE id = %s", (id,))
    mysql.connection.commit()
    cur.close()
    flash('Offer deleted successfully!', 'success')
    return redirect(url_for('admin_dashboard'))


if __name__ == '__main__':
    app.run(debug=True)
