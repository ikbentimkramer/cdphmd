# Accountability

This dashboard is created by 6 motivated students for the CBS in cooperation with the minor Data Wise, which is offered by the University of Groningen. This minor has the goal to let students understand data in practice, acquire conceptual and practical skills to analyse and report sources of information and lastly, participate in a data-driven project. The students in the project team have different study backgrounds, from business to sociology and from mathematics to psychology.

## Summary information

Below every indicator, a short summary can be found on the main findings. Six indicators are investigated in this dashboard, half are based on the objective CBS datasets. The CBS datasets are retrieved using Statline. Statline is a database where the CBS makes numerous databases publicly available. Statline is used to find relevant data for the objective indicators, which are housing stock, housing price and migration within the region.

* Housing stock - All types of houses (eg. apartments, vila, family house) that are available in a specified area.
* Housing price - The average selling price per year for houses in a specified area.
* Population dynamics - The net change of population for a specified area.

The WOON2018 dataset is used for the other three subjective indicators. The WOON2018 is a survey that is conducted by Dutch citizens and they are asked questions about their way of life, their satisfaction with their region, the type of house they live in, etc. WOON2018 is used to analyse data for the subjective indicators, which are satisfaction with the region, vacancy rate of homes in neighbourhood and desire to move. The age group and region of residence of the respondents were available in the dataset.

* Satisfaction with the region - The satisfaction of the inhabitants with the region they are living in. 
* Vacancy rate of homes in neighbourhood - The perceived change in the vacancy rate over the past 5 years of private and business properties that are available in the neighbourhood. 
* Desire to move - The desire to move to another place within the timeframe of two years. 

For more information regarding the analysis and cleaning of our dataset, see the ‘Final Report’ under ‘Downloads’. Several additional analysis methods, including statistical significance, can be found there.

## Merging municipalities

The visualizations regarding the registered indicators range from the years 2015-2019. During those years, quite some municipalities were merged or redistributed. The municipalities that currently exist are displayed in the dashboard. Some municipalities that are merged do not exist anymore and are therefore not displayed in the dashboard. However, the data from these municipalities is relevant data since it is part of the Northern Netherlands. To solve this issue, the choice is made to sum up the municipalities before the merge that are merged together to one municipality. When a municipality is merged into two different municipalities, the ratio between the division of the municipality is taken into account.

## Colour schemes
 
All our maps are using the colour palette provided by the "viridis" R package. This is known to be a printer-friendly, perceptually uniform and easy to read by those with colorblindness.

## Linear Graphs

Take into consideration that linear graphs from the Housing stock and the Housing price indicators do not start at 0. The boundaries of the y-axis are given by the lowest and the highest value of the respective indicator in the period 2015-2019. We have opted for this method because the scope of the dashboard is to show how the housing market changed in the period 2015-2019 and graphs that present these indicators at a smaller scale seem to be more informative, otherwise the line would look almost flat. Another reason this method was chosen is that there is a big difference in the values for different municipalities. Some are a tenth of the size of others. This makes it difficult to use the same scale for each municipality.
Therefore, please be aware of this when inspecting the line graphs and do not let the skewness of some lines trick you. Evaluate the change of number of house or the change in price in comparison to the total number of houses or the average selling price respectively.
## Legal accountability

On the 24th of May 2018, the GDPR was introduced by the European Union (EU). The GDPR obliged us to be aware of several things while using the data for the dashboard

*Right to information (Article 13 and 14): Data objects have the right to be informed about the procession and usage of their data
* Right of access (Article 15): The data subject has the right to know if his data is processed and where and who is processing it. Besides that, they have the right to access their own personal data.
* Right to rectification (Article 16): The data subject has the right to rectification if the personal data of the data subject is incorrect.
* Right to the restriction of processing (Article 18): The data subject has the right to limit the use of data under special circumstances.
* Right to object (Article 21): The data subject has the right to object if the personal data is shared with third parties.

Firstly, the European Parliament and Council of European Union (2016) shows in article 44 an exemption of article 15,16 and 18 for data processing that is performed by institutions that will use the data for scientific or statistical purposes. Since, CBS is an institutional organization that collects the data for statistical purposes it is exempt from articles 15, 16, and 18. The rights that are described in articles 13 and 14 are ensured by informing the data subjects of what is done with the collected data. Article 21 is not applicable for CBS, since CBS ensures that personable trackable data is not made publicly available.
