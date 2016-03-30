int main(int argc, char* argv[])
{
    // Variables
    char* filename;
    int switchCount=0;
    int toggleCount=0;
    int onSwitches = 0;
    clock_t timeStart, timeEnd;

    // For timing
    timeStart = clock();

    //
    // FILE LOADING
    //
    // Make sure we've been given a filename
    if(argc>1)
        filename = argv[1];
    else
        return 1;

    // Attempt to open it
    FILE* file = fopen(filename,"r");

    if(file==NULL)
        return 1;

    // Count the lines
    while(!feof(file))
    {
      char ch = fgetc(file);
      if(ch == '\n')
      {
        toggleCount++;
      }
    }

    // Reset and read in first line (switch count)
    // NOTE: First line unneeded unless program was modified to
    //  a) Have all switches originally "on"
    //  b) To check that toggles aren't out of range
    rewind(file);

    fscanf(file, "%d", &switchCount);

    // Assign memory for toggle intervals (2 arrays for Merge Sort)
    int *toggles          = (int*) malloc(toggleCount * 2 * sizeof(int));
    int *togglesWorkArray = (int*) malloc(toggleCount * 2 * sizeof(int));

    // Read in file data. Intervals go into a 1-dimensional array 2 at a time, transposed
    // If the left column is bigger, we swap the values so it's always an increasing interval (left<right)
    // We add 1 to the "end" of each interval so it's correctly calculated as a half-open interval
    for(int i=0; i<toggleCount*2; i+=2)
    {
        fscanf(file, "%d %d", &toggles[i], &toggles[i+1]);
        if(toggles[i]>toggles[i+1])
        {
            int tmp = toggles[i];
            toggles[i] = toggles[i+1];
            toggles[i+1] = tmp;
        }
        toggles[i+1] += 1;
    }

    fclose(file);

    //
    // SORTING AND FLIPPING SWITCHES
    //
    // Sort the data, uses a top down merge sort as described at https://en.wikipedia.org/wiki/Merge_sort
    TopDownMergeSort(toggles, togglesWorkArray, toggleCount*2);
    free(togglesWorkArray);

    // Flip switches
    for(int i=0; i<toggleCount*2; i+=2)
    {
        onSwitches += toggles[i+1] - toggles[i];
    }

    // Done.
    free(toggles);
    timeEnd = clock();
    printf("%d (took %f seconds)\n", onSwitches, (double)(timeEnd - timeStart) / CLOCKS_PER_SEC);

    return 0;
}
