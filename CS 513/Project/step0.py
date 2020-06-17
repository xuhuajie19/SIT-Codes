import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sklearn
import os
import warnings
import re
import math
import xgboost as xgb

from sklearn import preprocessing
from sklearn.utils import shuffle
from sklearn.svm import SVC
from sklearn.linear_model.logistic import LogisticRegression
from sklearn import metrics
from sklearn.feature_extraction.text import CountVectorizer

import sys

warnings.filterwarnings('ignore')

def getfilelen(x):
    length = 0
    f = open(x, encoding = 'utf-8', mode = 'r', errors='ignore')
    lines = f.readlines()
    for line in lines:
        length = length + len(line)
    f.close()
    return length

def getfileentropy(x):
    length = 0
    word = {}
    p = 0
    summ = 0
    f = open(x, encoding = 'utf-8', mode = 'r', errors='ignore')
    content = f.readlines()
    for i in content:
        for j in i:
            if j != '\n' and j != ' ':
                if j not in word.keys():
                    word[j] = 1
                else:
                    word[j] = word[j] + 1
            else:
                pass
    f.close()
    for i in word.keys():
        summ = summ + word[i]
    for i in word.keys():
        p = p - float(word[i])/summ * math.log(float(word[i])/summ,2)
    return p

def getfilefunc(x):
    content = ''
    content_list = []
    f = open(x, encoding = 'utf-8', mode = 'r', errors='ignore')
    lines = f.readlines()
    for line in lines:
        content = content + line.strip('\n')
    f.close()
    content_list = re.split(r'\(|\)|\[|\]|\{|\}|\s|\.',content)
    max_length = 0
    for i in content_list:
        if len(i) > max_length:
            max_length = len(i)
    #print(content_list)
    count_exec = 0
    count_file = 0
    count_zip = 0
    count_code = 0
    count_chr = 0
    count_re = 0
    count_other = 0
    for i in content_list:
        if 'assert' in i or 'system' in i or 'eval' in i or 'cmd_shell' in i or 'shell_exec' in i:
            count_exec = count_exec + 1
        if 'file_get_contents' in i or 'fopen' in i or 'fwrite' in i or 'readdir' in i or 'scandir' in i or 'opendir' in i or 'curl' in i:
            count_file = count_file + 1
        if 'base64_encode' in i or 'base64_decode' in i:
            count_code = count_code + 1
        if 'gzcompress' in i or 'gzuncompress' in i or 'gzinflate' in i or 'gzdecode' in i:
            count_zip = count_zip + 1
        if 'chr' in i or 'ord' in i:
            count_chr + count_chr + 1
        if 'str_replace' in i or 'preg_replace' in i or 'substr' in i:
            count_re = count_re + 1
        if 'create_function' in i or 'pack' in i:
            count_other = count_other + 1
    #print(x)
    return (max_length,count_exec,count_file,count_zip,count_code,count_chr,count_re,count_other)

def genkaggledata(amount):
    path = 'D:/Data'
    with open(path + '/datasets/zavadskyy/lots-of-code/php.txt',encoding = 'utf-8',mode = 'r', errors='ignore') as f:
        #f = open(path + '/data/kaggle/php.txt').read()
        count = 0
        codes = ""
        for line in f:
            if (line != '<?php\n'):
                codes += line
            else:
                fout = open(path + "/data/common/" + str(count) + '.php',encoding = 'utf-8',mode = 'w', errors='ignore')
                fout.write(codes)
                fout.close()
                count += 1
                #print(count)
                if (count == amount):
                    return
                codes = "<?php\n"

def buildROC(target_test,test_preds):
    fpr, tpr, threshold = metrics.roc_curve(target_test, test_preds)
    #print('threshold: ',threshold)
    roc_auc = metrics.auc(fpr, tpr)
    plt.title('Receiver Operating Characteristic')
    plt.plot(fpr, tpr, 'b', label = 'AUC = %0.2f' % roc_auc)
    plt.legend(loc = 'lower right')
    plt.plot([0, 1], [0, 1],'r--')
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    plt.gcf().savefig('roc.png')

path = os.getcwd()
path = 'D:/Data'
#genkaggledata()

files_webshell = os.listdir(path + "/data/webshell/")
files_common = os.listdir(path + "/data/common/")

labels_webshell = []
labels_common = []

for i in range(0,len(files_webshell)):
    labels_webshell.append(1)
    files_webshell[i] = path + "/data/webshell/" + files_webshell[i]
for i in range(0,len(files_common)):
    labels_common.append(0)
    files_common[i] = path + "/data/common/" + files_common[i]

DATA_SIZE = len(files_webshell) + len(files_common)
#print(DATA_SIZE)

files = files_webshell + files_common
labels = labels_webshell + labels_common

datadict = {'label':labels,'file':files}
df = pd.DataFrame(datadict,columns=['label','file'])

df['len'] = df['file'].map(lambda x:getfilelen(x)).astype(int)
df['entropy'] = df['file'].map(lambda x:getfileentropy(x)).astype(float)
df['func'] = df['file'].map(lambda x:getfilefunc(x))

df['exec'] = df['func'].map(lambda x:x[1])
df['file'] = df['func'].map(lambda x:x[2])
df['zip'] = df['func'].map(lambda x:x[3])
df['code'] = df['func'].map(lambda x:x[4])
df['chr'] = df['func'].map(lambda x:x[5])
df['re'] = df['func'].map(lambda x:x[6])
df['other'] = df['func'].map(lambda x:x[7])
df['maxlen'] = df['func'].map(lambda x:x[0])

fout = open('data.csv','w')
fout.write(df.filter(regex = 'label|len|entropy|maxlen|exec|zip|code|chr|re|other').to_csv(index=True))
fout.close()

scaler = preprocessing.StandardScaler()
for feat in ['len','entropy','maxlen','exec','zip','code','chr','re','other']:
    df[feat + '_s'] = scaler.fit_transform(df[feat].values.reshape(-1,1))

train_pre = df.filter(regex = 'label|len_s|entropy_s|maxlen_s|exec_s|zip_s|code_s|chr_s|re_s|other_s')
train_pre = shuffle(train_pre)

train_pre =train_pre.as_matrix()
y_train = train_pre[0:int(DATA_SIZE*0.9),0]
x_train = train_pre[0:int(DATA_SIZE*0.9),1:]

y_test = train_pre[int(DATA_SIZE*0.9):,0]
x_test = train_pre[int(DATA_SIZE*0.9):,1:]
##杀手锏：XGBoost算法
#params = {
#    'booster': 'gbtree',
#    'num_class': 2,               # 类别数，与 multisoftmax 并用
#    'gamma': 0.1,                  # 用于控制是否后剪枝的参数,越大越保守，一般0.1、0.2这样子。
#    'max_depth': 12,               # 构建树的深度，越大越容易过拟合
#    'lambda': 2,                   # 控制模型复杂度的权重值的L2正则化项参数，参数越大，模型越不容易过拟合。
#    'subsample': 0.7,              # 随机采样训练样本
#    'colsample_bytree': 0.7,       # 生成树时进行的列采样
#    'min_child_weight': 3,
#    'silent': 0,                   # 设置成1则没有运行信息输出，最好是设置为0.
#    'eta': 0.007,
#    'seed': 1000,
#    'nthread': 4,
#}

#params['eval_metric'] = 'error'
#num_round = 200
dtrain = xgb.DMatrix( x_train, label=y_train)
dtest = xgb.DMatrix( x_test, label=y_test)
evallist  = [(dtest,'test'), (dtrain,'train')]
model = xgb.XGBClassifier(max_depth=10, learn_rate=0.01, n_estimators=100,  verbosity = 2, booster = 'gbtree')
model.fit(x_train, y_train)

pred = model.predict(x_test, ntree_limit=200)
actu = y_test
print(pd.crosstab(actu,pred))
buildROC(actu,pred)
test_score = model.score(x_test, y_test)
print("Accurancy: ",test_score)
precision, recall, thresholds = metrics.precision_recall_curve(actu,pred)
f1 = metrics.f1_score(actu,pred)
print("Precision: ",precision[1])
print("Recall: ",recall[1])
print("F1: ",f1)