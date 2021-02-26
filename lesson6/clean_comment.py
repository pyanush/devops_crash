import re
with open('Vagrantfile') as file:
        for i in file.read().split('\n'):
          with open('Vagrantfile_', 'a') as file:
                  i = re.sub(r'(\#) (.+)', '', i)
                  if (len (i) > 3):
                        file.write(i+'\n')
                        print(i)
