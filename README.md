## Задача: написать свою реализацию ps ax используя анализ /proc
## Реализация:
Пишем шапку, потом сканируем директорию /proc/ на каталоги с цифровым именем.

В первом столбце выводим имя каталога в качестве pid.

Во втором столбце активный терминал если есть. Проверяем по наличию /dev/$var/fd/0, если есть, проверяем что это линк на символьное устройство и это не /dev/null. Если подходит, выводим в качестве терминала, если нет ставим ?

В третьем столбце выводим статус процесса. Берем его из /dev/$var/stat, третье поле.

В четвертом стобце выводим занятое процессорное время. Считаем сумму utime+ctime, делим на сто - получаем в секундах. Вычисляем минуты и секунды и выводим так же как в выводе ps ax.

В пятом столбце выводим команду запуска. Проверяем файл /proc/$var/cmdline. Если не пустой, то выводм из него строку запуска. Если пустой, то из /proc/$var/stat выводим имя запускающего файла(поле 2).

Тестировалось на CentOS 7 под root.
