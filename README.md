## Задача: написать свою реализацию ps ax используя анализ /proc
## Реализация:
Пишем шапку, потом сканируем директорию /proc/ на каталоги с цифровым именем.

Пишем все имена директорий в массив. Далее циклом идем по массиву.

В первом столбце выводим имя каталога в качестве pid.

Во втором столбце активный терминал если есть. Проверяем по наличию /dev/$i/fd/0, если есть, проверяем что это линк на символьное устройство и это не /dev/null. Если подходит, выводим в качестве терминала, если нет ставим '?'

В третьем столбце выводим статус процесса. Берем его из /dev/$i/status, строка со "State".

В четвертом стобце выводим занятое процессорное время. Считаем сумму utime+ctime, делим на сто - получаем в секундах. Вычисляем минуты и секунды и выводим так же как в выводе ps ax.

В пятом столбце выводим команду запуска. Проверяем файл /proc/$i/cmdline. Если не пустой, то выводим из него строку запуска. Если пустой, то из /proc/$i/stat выводим имя запускающего файла(поле 2).
