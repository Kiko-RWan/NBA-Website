import os
path = os.getcwd()
with open(f'{path}/../static/article/userpage/1_a.txt', 'r') as f:
    content = f.read()
    f.close()
print(content)
            