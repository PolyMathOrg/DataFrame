Since DataSeries is a subclass of OrderedDictionary which, for some reason, is not a SequenceableCollection, it doesn't understand some important messages defined in SequenceableCollection class.

I redefine these messages and add them to DataSeries