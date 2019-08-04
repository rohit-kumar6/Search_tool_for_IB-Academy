sudo apt-get install python3-venv

echo "setting up virtual environment"
python3 -m venv venv

echo "activating virtual environment"
. venv/bin/activate

pip install Flask
export FLASK_APP=__init__.py
export FLASK_ENV=development
flask run