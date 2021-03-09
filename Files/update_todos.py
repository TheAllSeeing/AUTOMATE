from file_management_utils import *

os.chdir(var('ACCESS'))
os.chdir('Agenda')
todos = find(escape(os.getcwd()) + ' -mindepth 1')
dossiers = [name[:-8].split('/')[-1] for name in todos]


def update():
    for todo_path, dossier in zip(todos, dossiers):
        with open(todo_path, 'r') as todo:
            contents = todo.readlines()
            if len(contents) >= 1 and contents[0].startswith('#+TITLE'):
                contents[0] = todo_title(dossier)
            else:
                contents.insert(0, todo_title(dossier))
            if len(contents) >= 2 and contents[1].startswith('#+ARCHIVE'):
                contents[1] = todo_archive(dossier)
            else:
                    contents.insert(1, todo_archive(dossier))
            if len(contents) >= 3 and contents[2].startswith('#+FILETAGS'):
                contents[2] = todo_tags(dossier)
            else:
                contents.insert(2, todo_tags(dossier))
        with open(todo_path, 'w') as todo:
          #  todo.write("".join(contents))
          pass
        print(''.join(contents))
        print()
        print()
    
