page 50534 "Performance Competency Line-Qt"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Performance Competency Line-Qt";

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
                field(Objectives; Rec.Objectives)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                 field("Action Plans"; Rec."Action Plans")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Indicators; Rec.Indicators)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
               
                field("Agreed Weighting"; Rec."Agreed Weighting")
                {
                    ApplicationArea=All;
                }
                field("Employee Comment"; Rec."Employee Comment")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Employee Score"; Rec."Employee Score")
                {
                    ApplicationArea = All;
                }
                field("Appraiser Remarks"; Rec."Appraiser Remarks")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Appraiser Score"; Rec."Appraiser Score")
                {
                    ApplicationArea = All;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
