# NLP Pipeline

<img src="/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/nlp-pipeline-overview.png" alt="nlp-pipeline" style="zoom:67%;" />

## **Sentence Hierarchy:**

A sentence typically follows a hierarchical structure consisting of the following components:

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/sentence-hierarchy.jpeg)

## **Standard NLP Workflow**

Typically, any NLP-based problem can be solved by a methodical workflow that has a sequence of steps. The major steps are depicted in the following figure.

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/nlp-workflow.png)

We usually start with a corpus of text documents and follow standard processes of text wrangling and pre-processing, parsing, and basic exploratory data analysis. Based on the initial insights, we usually represent the text using relevant feature engineering techniques. Depending on the problem at hand, we either focus on building predictive supervised models or unsupervised models, which usually focus more on pattern mining and grouping. Finally, we evaluate the model and the overall success criteria with relevant stakeholders or customers and deploy the final model for future usage.

## **NLP Pipeline:**

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/nlp-pipeline.png)

Above mentioned steps are used in a typical NLP pipeline, but you will skip steps or re-order steps depending on what you want to do and how your NLP library is implemented. For example, some libraries like spaCy do sentence segmentation much later in the pipeline using the results of the dependency parse.

## Blogs

* [**NLP Pipeline: Building an NLP Pipeline, Step-by-Step**](https://suneelpatel-in.medium.com/nlp-pipeline-building-an-nlp-pipeline-step-by-step-7f0576e11d08)
* [How does NLP work: A detailed Guide to make an NLP Pipeline](https://helloyubo.com/how-does-nlp-work-a-detailed-guide-to-make-an-nlp-pipeline/)

