report 50020 "Run End Of Month"
{
    Caption = 'Run End Of Month';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));
            trigger OnAfterGetRecord()
            begin
                Automations.ProcessAutomationsSTOLocal(Today);
            end;

            trigger OnPostDataItem()
            begin
                Message('Run End Of Month Complete');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Automations: Codeunit Automations;
}
