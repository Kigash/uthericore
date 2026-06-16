page 50527 "Quantitative Goals"
{
    PageType = List;
    SourceTable = "Quantitative Goal";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
