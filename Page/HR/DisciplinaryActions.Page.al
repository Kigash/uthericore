page 50427 "Disciplinary Actions"
{
    // version TL2.0

    PageType = List;
    SourceTable = 50218;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Terminate; Rec.Terminate)
                {
                    ApplicationArea = All;
                }
                field(Document; Rec.Document)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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
