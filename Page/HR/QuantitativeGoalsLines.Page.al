page 50429 "Quantitative Goals Lines"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Quantitative Goals Line";

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
                    MultiLine = true;
                }
                field(Objectives; Rec.Objectives)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Action Plans"; Rec."Action Plans")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Indicators; Rec.Indicators)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Agreed Weighting"; Rec."Agreed Weighting")
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
