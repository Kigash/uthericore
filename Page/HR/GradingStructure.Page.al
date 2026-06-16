page 50407 "Grading Structure"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Grading Structure";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field("Lower Value"; Rec."Lower Value")
                {
                    ApplicationArea = All;
                }
                field("Higher Value"; Rec."Higher Value")
                {
                    ApplicationArea = All;
                }
                field("Total (Out of 5)"; Rec."Total (Out of 5)")
                {
                    ApplicationArea = All;
                }
                field("% Bonus Payment"; Rec."% Bonus Payment")
                {
                    ApplicationArea = All;
                }
                field("% Salary Increment"; Rec."% Salary Increment")
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
}