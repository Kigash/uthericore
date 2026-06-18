page 50000 "Member Application Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Related Information,Comments,Approval Actions,Category 8';
    RefreshOnActivate = true;
    SourceTable = "Member Application";

    layout
    {
        area(content)
        {
            group(Individual)
            {
                Caption = 'Individual';
                Visible = IsVisibleIndividual;
                field(Category; Rec.Category)
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetVisible;
                    end;
                }

                field("No."; Rec."No.")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }

                field("First Name"; Rec."First Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Social Name"; Rec."Social Name")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Passport ID"; Rec."Passport ID")
                {
                    ApplicationArea = All;
                }
                field("Huduma No."; Rec."Huduma No.")
                {
                    ApplicationArea = All;
                }
                field("Age Classification"; Rec."Age Classification")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Company Code"; Rec."Checkoff Company Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Checkoff Company Name"; Rec."Checkoff Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group("GroupLink")
                {
                    Caption = '';
                    Visible = Rec.Category = 0;
                    field("Group Link Type"; Rec."Group Link Type")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            Rec."Group Link No." := '';
                        end;
                    }
                    group(GroupLinkNo)
                    {
                        Caption = '';
                        Visible = Rec."Group Link Type" > 0;
                        field("Group Link No."; Rec."Group Link No.")
                        {
                            ApplicationArea = All;
                        }
                    }

                }
                field("Introducer Member No."; Rec."Introducer Member No.")
                {
                    ApplicationArea = All;
                }
                field("Introducer Member Name"; Rec."Introducer Member Name")
                {
                    ApplicationArea = All;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    Caption = 'KRA PIN';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                group(IsGroupOfficial)
                {
                    Caption = '';
                    Visible = Rec."Group Link Type" > 0;
                    field("Is Group Official"; Rec."Is Group Official")
                    {
                        ApplicationArea = All;
                    }
                }
                group(GroupOfficialPosition)
                {
                    Caption = '';
                    Visible = Rec."Is Group Official" = true;
                    field("Group Official Position"; Rec."Group Official Position")
                    {
                        ApplicationArea = All;
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Group Details")
            {
                Caption = 'Group';
                Visible = IsVisibleGroup;
                field("Group Name"; Rec."Full Name")
                {
                    Caption = 'Group Name';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Group Registration No."; Rec."Registration No.")
                {
                    Caption = ' Registration No.';
                    ApplicationArea = All;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    Caption = ' Date of Registration';
                    ApplicationArea = All;
                }

                field("Group Meeting Day"; Rec."Group Meeting Day")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Time"; Rec."Group Meeting Time")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Frequency Option"; Rec."Group Meeting Frequency Option")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Venue"; Rec."Group Meeting Venue")
                {
                    ApplicationArea = All;
                }
                field("Last Meeting Date"; Rec."Last Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Min. Contribution per Meeting"; Rec."Min. Contribution per Meeting")
                {
                    ApplicationArea = All;
                }

                field("Office Location"; Rec."Office Location")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Activity; Rec.Activity)
                {
                    Caption = 'Group Activity';
                    ApplicationArea = All;
                }

                field("No. of Members"; Rec."No. of Members")
                {
                    ApplicationArea = All;
                }
                field("Group Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Group Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field(GroupApprovalStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Company Info")
            {
                Caption = 'Company';
                Visible = IsVisibleCompany;
                field("Company Name"; Rec."Full Name")
                {
                    Caption = 'Company Name';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }

                field("Company Activity"; Rec.Activity)
                {
                    Caption = 'Company Activity';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Company KRA PIN"; Rec."PIN No.")
                {
                    Caption = ' KRA PIN';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }

                field("Company Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(CompanyStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Joint)
            {
                Caption = 'Joint';
                Visible = IsVisibleJoint;
                field("Joint Name"; Rec."Full Name")
                {
                    Caption = 'Joint Name';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Joint ID"; Rec."National ID")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }

                field("Joint Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(JointStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

            group(Communication)
            {
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
                group("Residence")
                {
                    Caption = '';
                    Visible = Rec.Category = 0;
                    field("Current Residence"; Rec."Current Residence")
                    {
                        ApplicationArea = All;
                    }
                    field("Home Ownership"; Rec."Home Ownership")
                    {
                        ApplicationArea = All;
                    }
                    field("Home Village"; Rec."Home Village")
                    {
                        ApplicationArea = All;
                    }
                    field("Nearest LandMark"; Rec."Nearest LandMark")
                    {
                        ApplicationArea = All;
                    }
                }
            }

            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Created By Host Name"; Rec."Created By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Created By Host IP"; Rec."Created By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Created By Host MAC"; Rec."Created By Host MAC")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(MAPicture; "MA Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisiblePicture;
            }

            part(MAFrontID; "MA Front ID")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleFrontID;
            }
            part(MABackID; "MA Back ID")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleBackID;
            }
            part(MASignature; "MA Signature")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleSignature;
            }
            part(MACertificate; "MA Reg. Certficate")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleCR;
            }
            part(AttachmentFactBox; "Attachement FactBox")
            {
                Caption = 'Attachment';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Form)
            {
                action(AppForm)
                {
                    Caption = 'Member Application Form';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.FILTERGROUP(10);
                        Rec.SETRANGE("No.", Rec."No.");
                        Rec.SetRange("No.", Rec."No.");
                        Rec.FILTERGROUP(0);
                        Report.RUN(50013, true, false, Rec);
                    end;
                }
            }

            group("Approval Request")
            {
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';
                    Visible = IsVisibleSendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                        MemberApplication: Record "Member Application";
                    begin

                        Rec.ValidateFields;
                        CASE Rec.Category OF
                            Rec.Category::Individual:
                                BEGIN
                                    if not Rec.HasNextofKin() then
                                        Error(HasNoNextofKinErr);
                                END;
                        END;


                        IF ApprovalsMgmt.CheckMemberApplicationApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendMemberApplicationForApproval(Rec);

                        MemberApplication.Reset();
                        MemberApplication.SetRange("Group Link No.", Rec."No.");
                        if MemberApplication.FindSet() then begin
                            repeat
                                IF ApprovalsMgmt.CheckMemberApplicationApprovalPossible(MemberApplication) THEN
                                    ApprovalsMgmt.OnSendMemberApplicationForApproval(MemberApplication);
                            until MemberApplication.Next() = 0
                        end;
                        CurrPage.Close();

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    Visible = IsVisibleCancelApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelMemberApplicationApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Approve the requested changes.';
                    Visible = IsVisibleApprove;

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Reject the approval request.';
                    Visible = IsVisibleReject;

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;

                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = IsVisibleDelegate;


                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                            CurrPage.CLOSE;
                        END;

                    end;
                }
            }

        }
        area(Navigation)
        {
            action("Bank Accounts")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Member Bank Accounts List";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Nominees")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                RunObject = page Nominees;
                RunPageLink = "Application No." = field("No.");
            }
            action("Next of Kin")
            {
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                ApplicationArea = All;
                RunObject = page "Next of Kin";
                RunPageLink = "Application No." = field("No.");
            }
            action(Agencies)
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;//IsVisibleIndividual;
                ApplicationArea = All;
                RunObject = page "Member Agencies";
                RunPageLink = "Application No." = field("No.");

            }
            action("Monthly Contributions")
            {
                Ellipsis = true;
                Image = ElectronicPayment;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = page "Member Contribution";
                RunPageLink = "Application No." = field("No.");
            }
            action("Group Members")
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                RunObject = page "Group Member";
                RunPageLink = "Application No." = field("No.");

            }
            action("Group Trustees")
            {
                Image = Trace;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                RunObject = page "Group Trustee";
                RunPageLink = "Application No." = field("No.");

            }
            action("Company Signatories")
            {
                Image = Company;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;
                ApplicationArea = All;
                RunObject = page "Company Trustee";
                RunPageLink = "Application No." = field("No.");

            }

            action("Joint Members")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;
                ApplicationArea = All;
                // RunObject = page joint;

            }

            action("Add New Member")
            {
                Image = Company;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.TestField(Category, Rec.Category::Group);
                    Rec.TestField(Status, Rec.Status::New);
                    Rec.AddNewGroupMember();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        SetEditable;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitializeCategory;
    end;

    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
    end;


    local procedure SetVisible()
    begin
        IF Rec.Category = Rec.Category::Individual THEN BEGIN
            IsVisibleGroup := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleIndividual := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := TRUE;
            IsVisibleBackID := TRUE;
            IsVisibleFrontID := TRUE;
            IsVisibleCR := FALSE;
        END;
        IF Rec.Category = Rec.Category::Group THEN BEGIN
            IsVisibleIndividual := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleGroup := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := FALSE;
            IsVisibleFrontID := FALSE;
            IsVisibleBackID := FALSE;
            IsVisibleCR := TRUE;
        END;
        IF Rec.Category = Rec.Category::Company THEN BEGIN
            IsVisibleIndividual := FALSE;
            IsVisibleGroup := FALSE;
            IsVisibleCompany := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := FALSE;
            IsVisibleFrontID := FALSE;
            IsVisibleBackID := FALSE;
            IsVisibleCR := TRUE;
        END;
        IF Rec.Category = Rec.Category::Joint THEN BEGIN
            IsVisibleGroup := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleIndividual := FALSE;
            IsVisibleJoint := TRUE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := FALSE;
            IsVisibleFrontID := FALSE;
            IsVisibleBackID := FALSE;
            IsVisibleCR := FALSE;
        END;

        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsVisibleSendApprovalRequest := TRUE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
        END;
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := TRUE;
            IsVisibleApprove := true;
            IsVisibleDelegate := true;
            IsVisibleReject := true;
        END;
        IF Rec.Status = Rec.Status::Approved THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
        END;
        IF Rec.Status = Rec.Status::Rejected THEN BEGIN
            IsVisibleSendApprovalRequest := FALSE;
            IsVisibleCancelApprovalRequest := FALSE;
            IsVisibleApprove := false;
            IsVisibleDelegate := false;
            IsVisibleReject := false;
        END;
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE;

        IF Rec.Status = Rec.Status::"Pending Approval" THEN
            CurrPage.EDITABLE := FALSE;

        IF Rec.Status = Rec.Status::Approved THEN
            CurrPage.EDITABLE := FALSE;

        IF Rec.Status = Rec.Status::Rejected THEN
            CurrPage.EDITABLE := FALSE
    end;

    local procedure InitializeCategory()
    begin
        CategoryOptions := Text004;
        SelectedCategory := DIALOG.STRMENU(CategoryOptions, 1, Text005);
        CASE SelectedCategory OF
            0:
                CurrPage.CLOSE;
            1:
                BEGIN
                    Rec.Category := Rec.Category::Individual;
                    SetVisible;
                END;
            2:
                BEGIN
                    Rec.Category := Rec.Category::Group;
                    SetVisible;
                END;
            3:
                BEGIN
                    Rec.Category := Rec.Category::Company;
                    SetVisible;
                END;
            4:
                BEGIN
                    Rec.Category := Rec.Category::Joint;
                    SetVisible;
                END;
        END;
    end;

    var
        Text000: Label 'Are you sure you want to send member application %1 for approval?';
        Text001: Label 'Are you sure you want to cancel member application %1?';
        Text002: Label 'Member Application %1 has been submitted successfully';
        Text003: Label 'Member Application %1 has been cancelled successfully';
        [InDataSet]
        IsVisibleIndividual: Boolean;
        [InDataSet]
        IsVisibleGroup: Boolean;
        [InDataSet]
        IsVisibleCompany: Boolean;
        BeneficiaryType: Record "Beneficiary Type";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;
        //ApprovalsMgmt: Codeunit "1535";
        IsVisibleJoint: Boolean;
        IsVisibleSignature: Boolean;
        [InDataSet]
        IsVisiblePicture: Boolean;
        [InDataSet]
        IsVisibleFrontID: Boolean;
        [InDataSet]
        IsVisibleBackID: Boolean;
        IsVisibleCR: Boolean;
        IsVisibleApprove: Boolean;
        IsVisibleReject: Boolean;
        IsVisibleDelegate: Boolean;

        Text004: Label 'Individual,Group,Company,Joint';
        Text005: Label 'Choose Membership Category';
        CategoryOptions: Text[50];
        SelectedCategory: Integer;
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalComments: Page "Approval Comments";
        Text006: Label 'Member must be 18 years and above';
        Agency: Record "Member Agency";
        MemberContribution: Record "Member Contribution";
        HasNoNextofKinErr: Label 'No Next of Kin  details exist';
}
