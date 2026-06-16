page 51203 "Key Perfomance Indicator-MC"
{
    PageType = List;
    SourceTable = "Key Perfomance Indicator Setup";
    SourceTableView = where(Category = filter('MicroCredit Officer'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("No. of Accounts"; Rec."No. of Accounts")
                {
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                }
                field("Minimum Duration"; Rec."Minimum Duration")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Entrance Fee"; Rec."Entrance Fee")
                {
                }
                field("Member Category"; Rec."Member Category")
                {
                }
                field("Weighted Average"; Rec."Weighted Average")
                {
                }
                field("Calculation Mode"; Rec."Calculation Mode")
                {
                }
                field("Commission Value"; Rec."Commission Value")
                {
                }
                field(Category; Rec.Category)
                {

                }
            }
        }
    }

    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Category := Rec.Category::"MicroCredit Officer";
    end;
}

