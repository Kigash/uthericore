page 50068 "Coinage Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Coinage Setup";
    AutoSplitKey = true;
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            repeater(Coinage)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;

                }

            }

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetCurrentKey("Line No.")
    end;
}